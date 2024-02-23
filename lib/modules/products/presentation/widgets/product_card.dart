part of '../screen/product_screen.dart';

final class _ProductCard extends StatelessWidget {
  const _ProductCard(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 10),
          ListTile(
            leading: Card(
              clipBehavior: Clip.hardEdge,
              borderOnForeground: false,
              margin: EdgeInsets.zero,
              child: Image.network(
                product.thumbnail ?? '',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, object, __) => const Icon(
                  Icons.error_outline,
                  size: 50,
                ),
              ),
            ),
            title: Text(
              product.title ?? '',
              style: AppFonts.helvetica.bold().withSize(14),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.star_half_rounded,
                      size: 16,
                      color: AppColors.warning,
                    ),
                    Text(
                      product.rating?.toString() ?? '',
                      style: AppFonts.helvetica.bold(),
                    ).customPadding(left: 2)
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.attach_money_outlined,
                      size: 16,
                      color: AppColors.warning,
                    ),
                    Text(
                      "${product.price}\$",
                      style: AppFonts.helvetica.bold(),
                    ).customPadding(left: 2),
                  ],
                ),
              ],
            ),
          ),
          Text(
            product.description ?? '',
            style: AppFonts.helvetica,
          ).customPadding(left: 20, top: 10, bottom: 20),
        ],
      ),
    );
  }
}
