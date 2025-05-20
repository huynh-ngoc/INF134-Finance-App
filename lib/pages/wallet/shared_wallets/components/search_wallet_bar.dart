import 'package:flutter/material.dart';

class SearchWalletBar extends StatefulWidget {
  final Function(String) onChanged;
  final VoidCallback? onScanPressed;

  const SearchWalletBar({
    Key? key,
    required this.onChanged,
    this.onScanPressed,
  }) : super(key: key);

  @override
  _SearchWalletBarState createState() => _SearchWalletBarState();
}

class _SearchWalletBarState extends State<SearchWalletBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clearSearch() {
    setState(() {
      _controller.clear();
      widget.onChanged('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                hintText: 'Search wallets',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[400],
                ),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.grey[400],
                        ),
                        onPressed: _clearSearch,
                      )
                    : null,
                border: InputBorder.none,
              ),
            ),
          ),
          if (widget.onScanPressed != null)
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white,
                ),
                onPressed: widget.onScanPressed,
              ),
            ),
        ],
      ),
    );
  }
}