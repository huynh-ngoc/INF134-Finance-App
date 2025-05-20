// File: lib/components/invitations_bottom_sheet.dart

import 'package:flutter/material.dart';

Widget buildInvitationsBottomSheet({
  required List<Map<String, dynamic>> invitations,
  required Function(String) onAccept,
  required Function(String) onDecline,
}) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Icon(Icons.drag_handle, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        const Text(
          'Pending Invitations',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...invitations.map((invite) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    invite['walletName'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text('Invited by: ${invite['invitedBy']}'),
                  Text('Members: ${invite['members']}'),
                  Text('Invite Code: ${invite['inviteCode']}'),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => onDecline(invite['id']),
                        child: const Text('Decline'),
                      ),
                      ElevatedButton(
                        onPressed: () => onAccept(invite['id']),
                        child: const Text('Join'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    ),
  );
}
