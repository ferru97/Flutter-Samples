import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = "/add_product";

  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageURLcontroller = TextEditingController();
  final _imageFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();
  Map<String, String> _initValues = {
    "title": "",
    "description": "",
    "price": "",
    "imageURL": "",
  };
  bool _init = false;
  bool _isLoading = false;

  Product _editedProduct =
      Product(id: '', title: '', price: 0, description: '', imageUrl: '');

  @override
  initState() {
    _imageFocusNode.addListener(_updateImageURL);
  }

  @override
  void didChangeDependencies() {
    if (!_init) {
      final _prodId = ModalRoute.of(context)!.settings.arguments == null
          ? null
          : ModalRoute.of(context)!.settings.arguments as String;
      if (_prodId != null) {
        _editedProduct = Provider.of<ProductsProvider>(context, listen: false)
            .findById(_prodId);
        _initValues = {
          "title": _editedProduct.title,
          "description": _editedProduct.description,
          "price": _editedProduct.price.toString(),
          "imageURL": _editedProduct.imageUrl,
        };
        _imageURLcontroller.text = _initValues["imageURL"]!;
      }
      _init = true;
    }
  }

  void _updateImageURL() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _imageFocusNode.removeListener(_updateImageURL);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageURLcontroller.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  void saveForm() {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();

      if (_editedProduct.id.length > 0) {
        Provider.of<ProductsProvider>(context, listen: false)
            .updateProduct(_editedProduct.id, _editedProduct);
      } else {
        setState(() {
          _isLoading = true;
        });

        Provider.of<ProductsProvider>(context, listen: false)
            .addProduct(_editedProduct)
            .catchError((error) {
             return showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: Text("Error occurred"),
                  content: Text("Something went wrong\n${error.toString()}"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("Ok"),
                    )
                  ],
                );
              });
        }).then((_) {
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pop();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Added Product"),
        actions: [IconButton(onPressed: saveForm, icon: Icon(Icons.save))],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                        initialValue: _initValues["title"],
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Please provide a value";
                          else
                            return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                            isFavorite: _editedProduct.isFavorite,
                            id: _editedProduct.id,
                            title: value!,
                            price: _editedProduct.price,
                            description: _editedProduct.description,
                            imageUrl: _editedProduct.imageUrl,
                          );
                        },
                        decoration: InputDecoration(
                          labelText: 'Title',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        }),
                    TextFormField(
                      initialValue: _initValues["price"],
                      validator: (value) {
                        if (value!.isEmpty ||
                            double.tryParse(value) == null ||
                            double.parse(value) < 0)
                          return "Please provide a valid price";
                        else
                          return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          isFavorite: _editedProduct.isFavorite,
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          price: double.parse(value!),
                          description: _editedProduct.description,
                          imageUrl: _editedProduct.imageUrl,
                        );
                      },
                      focusNode: _priceFocusNode,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Price',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues["Description"],
                      validator: (value) {
                        if (value!.isEmpty)
                          return "Please provide a description";
                        else
                          return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          isFavorite: _editedProduct.isFavorite,
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          price: _editedProduct.price,
                          description: value.toString(),
                          imageUrl: _editedProduct.imageUrl,
                        );
                      },
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 8, right: 8),
                          decoration: BoxDecoration(
                              border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          )),
                          child: _imageURLcontroller.text.isEmpty
                              ? Text("Enter URL")
                              : FittedBox(
                                  fit: BoxFit.cover,
                                  child:
                                      Image.network(_imageURLcontroller.text),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty)
                                return "Please provide a image URL";
                              else
                                return null;
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                isFavorite: _editedProduct.isFavorite,
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                price: _editedProduct.price,
                                description: _editedProduct.description,
                                imageUrl: value!,
                              );
                            },
                            decoration: InputDecoration(labelText: "Text URL"),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageURLcontroller,
                            focusNode: _imageFocusNode,
                            onFieldSubmitted: (_) => saveForm(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
