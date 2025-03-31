import 'package:flutter/material.dart';

class CustomListWidget<T> extends StatelessWidget {
  final List<T> items;
  final bool isLoading;
  final bool dataIsNull;
  final Widget Function(T) itemBuilder;
  final String title;
  final String? noDataMessage;
  final void Function(BuildContext, T)? onItemTap;
  final bool ownStyle;

  const CustomListWidget({
    super.key,
    required this.items,
    required this.isLoading,
    required this.dataIsNull,
    required this.itemBuilder,
    required this.title,
    this.noDataMessage,
    this.onItemTap,
    this.ownStyle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isLoading)
          const Center(child: CircularProgressIndicator())
        else if (dataIsNull || items.isEmpty)
          _buildDefaultNoDataWidget(noDataMessage ?? 'No hay datos disponibles.')
        else
          Column(
            children: items.map((item) {
              return GestureDetector(
                onTap: onItemTap != null ? () => onItemTap!(context, item) : null,
                child: ownStyle
                    ? itemBuilder(item)
                    : Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(bottom: 12.0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(29, 43, 73, 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: itemBuilder(item),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildDefaultNoDataWidget(String message) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(123, 36, 46, 73),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
