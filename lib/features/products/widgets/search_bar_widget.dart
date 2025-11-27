import 'package:flutter/material.dart';
import '../../../core/config/app_text_styles.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onSearch;
  final VoidCallback? onClear;
  final String? initialQuery;

  const SearchBarWidget({
    super.key,
    required this.onSearch,
    this.onClear,
    this.initialQuery,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _controller.clear();
    _focusNode.unfocus();
    if (widget.onClear != null) {
      widget.onClear!();
    } else {
      widget.onSearch('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        // color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(
        //   color: Colors.grey[300]!,
        //   width: 1,
        // ),
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        onSubmitted: widget.onSearch,
        textInputAction: TextInputAction.search,
        style: AppTextStyles.poppins(fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Search products...',
          hintStyle: AppTextStyles.poppins(
            fontSize: 14,
            color: Colors.grey[500],
          ),
          prefixIcon: Icon(Icons.search, color: Colors.grey[600], size: 22),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey[600], size: 20),
                  onPressed: _clearSearch,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        onChanged: (value) {
          setState(() {}); // Rebuild to show/hide clear button
        },
      ),
    );
  }
}
