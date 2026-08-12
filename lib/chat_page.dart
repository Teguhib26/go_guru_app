import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatPage extends StatefulWidget {
  final String guruName;
  final String guruAvatar;
  final String instrument;

  const ChatPage({
    super.key,
    required this.guruName,
    required this.guruAvatar,
    required this.instrument,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  bool _isTyping = false;

  final List<Map<String, dynamic>> _messages = [
    {
      'message': 'Halo! Saya tertarik untuk les ${'Gitar'} privat dengan Anda.',
      'isMe': true,
      'time': '09:30',
    },
    {
      'message': 'Halo! Terima kasih sudah menghubungi saya. Dengan senang hati saya siap mengajarkan ${'Gitar'} untuk Anda!',
      'isMe': false,
      'time': '09:32',
    },
    {
      'message': 'Kapan jadwal kosong Anda untuk les pertama?',
      'isMe': true,
      'time': '09:33',
    },
    {
      'message': 'Untuk jadwal, saya tersedia setiap Senin, Rabu, dan Jumat sore pukul 14:00 - 17:00. Apakah ada waktu yang cocok untuk Anda?',
      'isMe': false,
      'time': '09:35',
    },
    {
      'message': 'Senin sore jam 14:00 terdengar cocok. Berapa tarifnya?',
      'isMe': true,
      'time': '09:36',
    },
    {
      'message': 'Baik! Untuk tarif les privat ${'Gitar'}, saya charger Rp250.000 per jam. Apakah Anda sudah memiliki alat musik sendiri atau perlu alat dari saya?',
      'isMe': false,
      'time': '09:38',
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    HapticFeedback.lightImpact();

    final now = TimeOfDay.now();
    final timeString = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    setState(() {
      _messages.add({
        'message': _messageController.text.trim(),
        'isMe': true,
        'time': timeString,
      });
      _messageController.clear();
      _isTyping = false;
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFECE5DD),
      body: Column(
        children: [
          // Header - Edge to edge
          Container(
            padding: EdgeInsets.only(top: topPadding + 8, left: 8, right: 8, bottom: 8),
            decoration: const BoxDecoration(
              color: Color(0xFF4CAF50),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                Stack(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          widget.guruAvatar,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xFFE8F5E9),
                              child: const Icon(
                                Icons.person,
                                color: Color(0xFF4CAF50),
                                size: 24,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.guruName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        'Online',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                ),
              ],
            ),
          ),

          // Message List
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isMe = message['isMe'] as bool;

                bool isFirst = true;
                if (index > 0) {
                  final prevMessage = _messages[index - 1];
                  isFirst = prevMessage['isMe'] != isMe;
                }

                bool isLast = true;
                if (index < _messages.length - 1) {
                  final nextMessage = _messages[index + 1];
                  isLast = nextMessage['isMe'] != isMe;
                }

                return _buildMessageBubble(message, isMe, isFirst, isLast);
              },
            ),
          ),

          // Input Area - Edge to edge
          Container(
            padding: EdgeInsets.only(
              left: 12,
              right: 12,
              top: 8,
              bottom: bottomPadding + 8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.attach_file,
                    color: Color(0xFF7D7D7D),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            focusNode: _focusNode,
                            onChanged: (value) {
                              setState(() {
                                _isTyping = value.isNotEmpty;
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: 'Ketik pesan...',
                              hintStyle: TextStyle(
                                color: Color(0xFF9E9E9E),
                                fontSize: 15,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            style: const TextStyle(fontSize: 15),
                            maxLines: 4,
                            minLines: 1,
                            textInputAction: TextInputAction.send,
                            onSubmitted: (_) => _sendMessage(),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Color(0xFF7D7D7D),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4CAF50),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _sendMessage,
                    icon: Icon(
                      _isTyping ? Icons.send : Icons.mic,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message, bool isMe, bool isFirst, bool isLast) {
    return Padding(
      padding: EdgeInsets.only(
        top: isFirst ? 8.0 : 2.0,
        bottom: isLast ? 8.0 : 2.0,
      ),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: ClipOval(
                child: Image.asset(
                  widget.guruAvatar,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFE8F5E9),
                      child: const Icon(
                        Icons.person,
                        color: Color(0xFF4CAF50),
                        size: 16,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.72,
              ),
              padding: EdgeInsets.only(
                left: isMe ? 16 : 12,
                right: isMe ? 16 : 12,
                top: isFirst ? 10 : 4,
                bottom: isLast ? 10 : 4,
              ),
              decoration: BoxDecoration(
                color: isMe ? const Color(0xFF4CAF50) : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isMe ? 18 : (isFirst ? 4 : 18)),
                  bottomRight: Radius.circular(isMe ? (isFirst ? 4 : 18) : 18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message['message'] as String,
                    style: TextStyle(
                      color: isMe ? Colors.white : const Color(0xFF1A1A1A),
                      fontSize: 15,
                      height: 1.3,
                    ),
                  ),
                  if (isLast) ...[
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          message['time'] as String,
                          style: TextStyle(
                            color: isMe ? Colors.white70 : Colors.grey[500],
                            fontSize: 11,
                          ),
                        ),
                        if (isMe) ...[
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.done_all,
                            size: 14,
                            color: Colors.white70,
                          ),
                        ],
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (isMe) const SizedBox(width: 8),
        ],
      ),
    );
  }
}
