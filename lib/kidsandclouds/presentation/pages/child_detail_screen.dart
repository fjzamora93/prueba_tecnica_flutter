import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChildDetailScreen extends ConsumerStatefulWidget {
  final String childId;
  const ChildDetailScreen({super.key, required this.childId});

  @override
  ConsumerState<ChildDetailScreen> createState() => _ChildDetailScreenState();
}

class _ChildDetailScreenState extends ConsumerState<ChildDetailScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Child Detail'),
      ),
      body: Center(
        child: Text('Details for child with ID: ${widget.childId}'),
      ),
    );
  }
}
  