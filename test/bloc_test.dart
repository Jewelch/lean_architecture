// import 'package:flutter_test/flutter_test.dart';
// import 'package:lean_architecture/modules/product_details/domain/entities/product.dart';
// import 'package:lean_architecture/modules/product_details/domain/usecases/get_product_by_id.dart';
// import 'package:lean_architecture/modules/product_details/presentation/bloc/product_bloc.dart';
// import 'package:lean_architecture/modules/product_details/presentation/bloc/product_events.dart';
// import 'package:lean_architecture/modules/product_details/presentation/bloc/product_states.dart';
// import 'package:mocktail/mocktail.dart';

// class MockGetProductByIdUC extends Mock implements GetProductByIdUC {}

// void main() {
//   late ProductDetailsBlocImpl bloc;
//   late MockGetProductByIdUC mockGetProductByIdUC;

//   setUp(() {
//     mockGetProductByIdUC = MockGetProductByIdUC();
//     bloc = ProductDetailsBlocImpl(mockGetProductByIdUC);
//   });

//   test('initial state should be Idle', () {
//     expect(bloc.state, Idle());
//   });

//   test('loading product details emits Loading then Success or Error', () async {
//     const productId = 1;
//     const product = Product(title: 'Test Product');

//     // Stub the call to return a successful result
//     when(() => mockGetProductByIdUC.call(any())).thenAnswer((_) async => const Right(product));

//     final expectedStates = [
//       Loading(),
//       Success(product: product),
//     ];

//     expectLater(bloc.stream, emitsInOrder(expectedStates));

//     bloc.add(GetProduct(productId));

//     verify(() => mockGetProductByIdUC.call(const Params(id: productId))).called(1);
//   });

//   test('clear product details emits Idle', () {
//     final expectedStates = [
//       Idle(),
//     ];

//     expectLater(bloc.stream, emitsInOrder(expectedStates));

//     bloc.add(ClearProduct());

//     verifyNever(() => mockGetProductByIdUC.call(any()));
//   });
// }
