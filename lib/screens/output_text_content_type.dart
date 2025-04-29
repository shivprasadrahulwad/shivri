// import 'package:flutter/material.dart';
// import 'package:shivri/models/message.dart';

// class OutputTextContentType extends MessageContent {
//   final bool isFromUser;

//   OutputTextContentType({this.isFromUser = false});

//   // Track selected button
//   static int _selectedButtonIndex = -1;

//   @override
//   Widget buildContent(BuildContext context) {
//     return StatefulBuilder(
//       builder: (context, setState) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Button row
//             Container(
//               margin: const EdgeInsets.only(bottom: 8),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 4),
//                   child: Row(
//                     children: [
//                       _buildActionButton(
//                         context,
//                         index: 0,
//                         icon: Icons.search_rounded,
//                         label: 'Search',
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
//                         ),
//                         isSelected: _selectedButtonIndex == 0,
//                         onTap: () {
//                           setState(() {
//                             _selectedButtonIndex = 0;
//                           });
//                         },
//                       ),
//                       const SizedBox(width: 10),
//                       _buildActionButton(
//                         context,
//                         index: 1,
//                         icon: Icons.source_rounded,
//                         label: 'Sources',
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFF11998E), Color(0xFF38EF7D)],
//                         ),
//                         isSelected: _selectedButtonIndex == 1,
//                         onTap: () {
//                           setState(() {
//                             _selectedButtonIndex = 1;
//                           });
//                         },
//                       ),
//                       const SizedBox(width: 10),
//                       _buildActionButton(
//                         context,
//                         index: 2,
//                         icon: Icons.analytics_rounded,
//                         label: 'Analyze',
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFFFF416C), Color(0xFFFF4B2B)],
//                         ),
//                         isSelected: _selectedButtonIndex == 2,
//                         onTap: () {
//                           setState(() {
//                             _selectedButtonIndex = 2;
//                           });
//                         },
//                       ),
//                       const SizedBox(width: 10),
//                       _buildActionButton(
//                         context,
//                         index: 3,
//                         icon: Icons.summarize_rounded,
//                         label: 'Summarize',
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFFF857A6), Color(0xFFFF5858)],
//                         ),
//                         isSelected: _selectedButtonIndex == 3,
//                         onTap: () {
//                           setState(() {
//                             _selectedButtonIndex = 3;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
            
//             // Content based on selection
//             if (_selectedButtonIndex >= 0)
//               _buildSelectedContent(_selectedButtonIndex),
//           ],
//         );
//       }
//     );
//   }

//   Widget _buildSelectedContent(int index) {
//     switch (index) {
//       case 0:
//         return _buildContentCard(
//           'Searching for relevant information...',
//           Icons.search,
//           const Color(0xFF6A11CB),
//         );
//       case 1:
//         return _buildContentCard(
//           'Here are the sources I\'ve used for this information:',
//           Icons.source_rounded,
//           const Color(0xFF11998E),
//         );
//       case 2:
//         return _buildContentCard(
//           'I\'m analyzing your request and breaking it down step by step...',
//           Icons.analytics_rounded,
//           const Color(0xFFFF416C),
//         );
//       case 3:
//         return _buildContentCard(
//           'Let me summarize the key points for you:',
//           Icons.summarize_rounded,
//           const Color(0xFFF857A6),
//         );
//       default:
//         return const SizedBox.shrink();
//     }
//   }

//   Widget _buildContentCard(String message, IconData icon, Color accentColor) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[850],
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: accentColor.withOpacity(0.5),
//           width: 1,
//         ),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(
//             icon,
//             color: accentColor,
//             size: 20,
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               message,
//               style: TextStyle(
//                 color: Colors.white.withOpacity(0.9),
//                 fontSize: 14,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButton(
//     BuildContext context, {
//     required int index,
//     required IconData icon,
//     required String label,
//     required Gradient gradient,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: gradient,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(12),
//           child: Stack(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//                 child: Row(
//                   children: [
//                     Icon(
//                       icon,
//                       size: 18,
//                       color: Colors.white,
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       label,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               if (isSelected)
//                 Positioned(
//                   right: 0,
//                   left: 0,
//                   bottom: 0,
//                   child: Container(
//                     height: 3,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(1.5),
//                     ),
//                   ),
//                 ),
//               if (isSelected)
//                 Positioned(
//                   right: 4,
//                   top: 4,
//                   child: Container(
//                     padding: const EdgeInsets.all(2),
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       Icons.check,
//                       size: 12,
//                       color: gradient.colors.first,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:shivri/models/message.dart';

class OutputTextContentType extends MessageContent {
  final bool isFromUser;

  OutputTextContentType({this.isFromUser = false});

  // Track selected button
  static int _selectedButtonIndex = -1;

  @override
  Widget buildContent(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Button row
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    _buildActionButton(
                      context,
                      index: 0,
                      icon: Icons.search_rounded,
                      label: 'Search',
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                      ),
                      isSelected: _selectedButtonIndex == 0,
                      onTap: () {
                        setState(() {
                          _selectedButtonIndex = 0;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    _buildActionButton(
                      context,
                      index: 1,
                      icon: Icons.source_rounded,
                      label: 'Sources',
                      gradient: const LinearGradient(
                        colors: [Color(0xFF11998E), Color(0xFF38EF7D)],
                      ),
                      isSelected: _selectedButtonIndex == 1,
                      onTap: () {
                        setState(() {
                          _selectedButtonIndex = 1;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    _buildActionButton(
                      context,
                      index: 2,
                      icon: Icons.analytics_rounded,
                      label: 'Analyze',
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF416C), Color(0xFFFF4B2B)],
                      ),
                      isSelected: _selectedButtonIndex == 2,
                      onTap: () {
                        setState(() {
                          _selectedButtonIndex = 2;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    _buildActionButton(
                      context,
                      index: 3,
                      icon: Icons.summarize_rounded,
                      label: 'Summarize',
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF857A6), Color(0xFFFF5858)],
                      ),
                      isSelected: _selectedButtonIndex == 3,
                      onTap: () {
                        setState(() {
                          _selectedButtonIndex = 3;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content based on selection
          if (_selectedButtonIndex >= 0)
            _buildSelectedContent(_selectedButtonIndex),
        ],
      );
    });
  }

  Widget _buildSelectedContent(int index) {
    switch (index) {
      case 0:
        return _buildContentCard(
          'Searching for relevant information...',
          Icons.search,
          const Color(0xFF6A11CB),
        );
      case 1:
        return _buildSourcesList();
      case 2:
        return _buildContentCard(
          'I\'m analyzing your request and breaking it down step by step...',
          Icons.analytics_rounded,
          const Color(0xFFFF416C),
        );
      case 3:
        return _buildContentCard(
          'Let me summarize the key points for you:',
          Icons.summarize_rounded,
          const Color(0xFFF857A6),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildSourcesList() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildSourceItem(
            index: 1,
            title: 'worldbank',
            url: 'worldbank.org/en/country/ind...',
            description: 'India Overview: Development news, research...',
            content:
                'Despite challenging global conditions, India remains the world\'s fastest growing major economy, growing at a rapid clip of 8.2 percent in FY23/24. Growth was ...',
            icon: Icons.language,
          ),
          // const Divider(height: 1, color: Colors.grey),
          _buildSourceItem(
            index: 2,
            title: 'en.wikipedia',
            url: 'en.wikipedia.org/wiki/Economy_o...',
            description: 'Economy of India - Wikipedia',
            content:
                'Economy of India : Neutral increase 1,428,627,663 (1st; 2024 est.) · Increase \$4.27 trillion (nominal; FY2025) · Increase \$17.36 trillion (PPP; FY2025) · Increase ...',
            icon: Icons.article_outlined,
            iconBackground: Colors.white,
          ),
          // const Divider(height: 1, color: Colors.grey),
          _buildSourceItem(
            index: 3,
            title: 'TRADING ECONOMICS',
            url: 'tradingeconomics.com/india/full-yea...',
            description: 'India Fiscal Year GDP Growth - Trading...',
            content: 'Full Year GDP Growth in India decreased to 6.50 percent',
            icon: Icons.bar_chart,
            iconBackground: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildSourceItem({
    required int index,
    required String title,
    required String url,
    required String description,
    required String content,
    required IconData icon,
    Color iconBackground = Colors.transparent,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                icon,
                size: 20,
                color: iconBackground == Colors.transparent
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '$index · ',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  url,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentCard(String message, IconData icon, Color accentColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: accentColor.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: accentColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
    required Gradient gradient,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      size: 18,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: Container(
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
