import 'dart:io';

import 'package:shop_app/core/enum.dart';
import 'package:shop_app/core/http/http_requests.dart';
import 'package:shop_app/core/http/network_service_response.dart';
import 'package:shop_app/core/http/url.dart';
import 'package:shop_app/core/repository/db.dart';
import 'package:shop_app/core/shared_function.dart';
import 'package:shop_app/module/product/model/model.dart';

class ProductProvider extends BasedHttpRequests
{

  Future<List<Product>> getProductFromApi()async

  {
   try
   {
     List<Product> product=[];
     NetworkServiceResponse response =await getData(AppUrl.productGetUrl);

     if(response.status==EnumStatus.complete)
     {
       for(Map<String,dynamic> data in response.data)
       {
         product.add(Product.fromJson(data));
       }

       ProductDatabase.instance.insertProducts(product);
       return product;

     }

   }
   on SocketException{
     return await ProductDatabase.instance.getAllProducts();

   }
   catch(e,s){
     globalPrint("error catch $e $s");
   }
   return  await ProductDatabase.instance.getAllProducts();
  }



}