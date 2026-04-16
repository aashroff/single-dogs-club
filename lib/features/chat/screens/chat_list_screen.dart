import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/dimensions.dart';
import 'package:go_router/go_router.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages', style: AppTypography.headlineMedium),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        children: [
          // Matches section
          Text('New Matches', style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, i) => Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  children: [
                    Container(
                      width: 64, height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.sand,
                        border: Border.all(
                          color: AppColors.coral.withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                      child: const Center(child: Text('\uD83D\uDC36', style: TextStyle(fontSize: 28))),
                    ),
                    const SizedBox(height: 6),
                    Text('Dog ${i + 1}', style: AppTypography.bodySmall.copyWith(fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Conversations
          Text('Conversations', style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          ...List.generate(5, (i) => _ChatTile(
            index: i,
            onTap: () => context.go('/chat/chat_$i'),
          )),

          if (true) ...[
            // Empty state for when no chats exist
            // const SizedBox(height: 40),
            // _EmptyChatState(),
          ],
        ],
      ),
    );
  }
}

class _ChatTile extends StatelessWidget {
  final int index;
  final VoidCallback onTap;

  const _ChatTile({required this.index, required this.onTap});

  static const _names = ['Sarah & Max', 'Jake & Cooper', 'Emily & Buddy', 'Chris & Rocky', 'Priya & Mango'];
  static const _messages = [
    'Shall we meet at the park on Saturday?',
    'Cooper loved playing with your dog!',
    'What time works best for you?',
    'Great walk today, thanks!',
    'Are you free this weekend?',
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: index == 0 ? AppColors.coral.withOpacity(0.04) : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Row(
          children: [
            Container(
              width: 52, height: 52,
              decoration: const BoxDecoration(
                color: AppColors.sand,
                shape: BoxShape.circle,
              ),
              child: const Center(child: Text('\uD83D\uDC36', style: TextStyle(fontSize: 24))),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_names[index % 5], style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w700)),
                      Text('${index + 1}h ago', style: AppTypography.bodySmall.copyWith(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _messages[index % 5],
                    style: AppTypography.bodySmall.copyWith(
                      color: index == 0 ? AppColors.textPrimary : AppColors.textMuted,
                      fontWeight: index == 0 ? FontWeight.w500 : FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (index == 0)
              Container(
                width: 10, height: 10,
                decoration: const BoxDecoration(
                  color: AppColors.coral,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
