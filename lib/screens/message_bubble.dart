// import 'package:flutter/material.dart';
// import 'package:shivri/models/message.dart';

// class MessageBubble extends StatelessWidget {
//   final Message message;
  
//   const MessageBubble({
//     super.key,
//     required this.message,
//   });

//   @override
//   Widget build(BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (!message.isFromUser)
//           Padding(
//             padding: const EdgeInsets.only(right: 12.0, top: 4.0),
//             child: Icon(Icons.ac_unit),
//           ),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // First display the options UI
//               if (!message.isFromUser) message.options.buildContent(context),
//               // Then display the actual message content
//               message.content.buildContent(context),
//               if (!message.isFromUser) _buildMessageActions(),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

//   Widget _buildMessageActions() {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 16.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               _buildActionButton(Icons.content_copy, 'Copy'),
//               _buildActionButton(Icons.thumb_up_outlined, 'Thumbs up'),
//               _buildActionButton(Icons.thumb_down_outlined, 'Thumbs down'),
//               const SizedBox(width: 8),
//               TextButton.icon(
//                 onPressed: () {},
//                 icon: const Icon(Icons.refresh, size: 16),
//                 label: const Text('Retry'),
//                 style: TextButton.styleFrom(
//                   foregroundColor: Colors.grey,
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 4.0),
//           child: Center(
//             child: Text(
//               'Claude can make mistakes.\nPlease double-check responses.',
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey[500],
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildActionButton(IconData icon, String tooltip) {
//     return IconButton(
//       icon: Icon(icon),
//       onPressed: () {},
//       iconSize: 20,
//       color: Colors.grey,
//       tooltip: tooltip,
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:shivri/models/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  
  const MessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First display the options UI above everything else
          if (!message.isFromUser) 
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: message.options.buildContent(context),
            ),
          // Then the row with icon and message content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!message.isFromUser)
                Padding(
                  padding: const EdgeInsets.only(right: 12.0, top: 4.0),
                  child: Icon(Icons.ac_unit),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display the actual message content
                    message.content.buildContent(context),
                    if (!message.isFromUser) _buildMessageActions(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageActions() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildActionButton(Icons.content_copy, 'Copy'),
              _buildActionButton(Icons.thumb_up_outlined, 'Thumbs up'),
              _buildActionButton(Icons.thumb_down_outlined, 'Thumbs down'),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text('Retry'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Center(
            child: Text(
              'Claude can make mistakes.\nPlease double-check responses.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String tooltip) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () {},
      iconSize: 20,
      color: Colors.grey,
      tooltip: tooltip,
    );
  }
}