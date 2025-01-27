import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:growmind_tutuor/features/home/data/model/fetch_category_model.dart';
import 'package:growmind_tutuor/features/home/domain/entities/fetch_model.dart';
import 'package:growmind_tutuor/features/home/domain/repository/fetch_category_repo.dart';

class FetchCategoryRepoimpl implements FetchCategoryRepo {
  final FirebaseFirestore firestore;
  FetchCategoryRepoimpl(this.firestore);

  @override
  Future<List<Category>> fetchCategories() async {
    final snapshot = await firestore.collection('category').get();
    return snapshot.docs
        .map((doc) => CategoryModel.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<List<Subcategory>> fetchSubCategories(String categoryId) async {
    final snapshot = await firestore
        .collection('category')
        .doc(categoryId)
        .collection('subcategory')
        .get();
    return snapshot.docs
        .map((doc) => SubCategoryModel.fromFirestore(doc.data()))
        .toList();
  }
}
