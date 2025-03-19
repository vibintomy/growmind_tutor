 import 'package:flutter/material.dart';
import 'package:growmind_tutuor/features/chat/presentation/bloc/chat_bloc/chat_state.dart';
import 'package:intl/intl.dart';

Padding chatUi(BuildContext context, ScrollController scrollController,
    ChatLoaded state, String tutorId) {

      String formatMessageDate(DateTime date) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));
      final messageDate = DateTime(date.year, date.month, date.day);

      if (messageDate == today) {
        return "Today";
      } else if (messageDate == yesterday) {
        return "Yesterday";
      } else {
        return DateFormat('MMMM d, y').format(date);
      }
    }

  final sortedMessages = List.from(state.message);
  sortedMessages.sort((a, b) => a.timeStamp.millisecondsSinceEpoch
      .compareTo(b.timeStamp.millisecondsSinceEpoch));

  // Group messages by date - more precise conversion
  final Map<String, List<dynamic>> messagesByDate = {};
  
  for (final message in sortedMessages) {
    // Make sure we're properly converting the timestamp
    final messageDate = DateTime.fromMillisecondsSinceEpoch(
        message.timeStamp.millisecondsSinceEpoch);
    // Use a more precise date key format
    final dateKey = DateFormat('yyyy-MM-dd').format(messageDate);
    
    if (!messagesByDate.containsKey(dateKey)) {
      messagesByDate[dateKey] = [];
    }
    
    messagesByDate[dateKey]!.add({
      'message': message,
      'date': messageDate,
    });
  }

  // Sort dates
  final sortedDates = messagesByDate.keys.toList()
    ..sort((a, b) => a.compareTo(b));

  return Padding(
    padding: const EdgeInsets.only(bottom: 90),
    child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/logo/telegrame background 🩷🥹.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView.builder(
        controller: scrollController,
        itemCount: sortedDates.length,
        itemBuilder: (context, dateIndex) {
          final dateKey = sortedDates[dateIndex];
          final messagesForDate = messagesByDate[dateKey]!;
          // Make sure we're getting the date correctly
          final firstMessageDate = messagesForDate.first['date'] as DateTime;
          
          return Column(
            children: [
              // Date header
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  formatMessageDate(firstMessageDate),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              // Messages for this date
              ...messagesForDate.map((messageData) {
                final message = messageData['message'];
                final isMe = message.senderId == tutorId;
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.blue[100] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7, // Reduced size
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            message.message,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14, // Smaller font size
                            ),
                          ),
                        ),
                        const SizedBox(height: 2), // Reduced spacing
                        Text(
                          DateFormat('HH:mm').format(
                            DateTime.fromMillisecondsSinceEpoch(
                              message.timeStamp.millisecondsSinceEpoch
                            )
                          ),
                          style: TextStyle(
                            fontSize: 9, // Smaller time font
                            color: Colors.grey[600]
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          );
        },
      ),
    ),
  );
}