import 'package:daikita/src/models/getChatListDetailModel.dart';
import 'package:daikita/src/models/getChatListModel.dart';
import 'package:daikita/src/models/getCheckChatDetailModel.dart';
import 'package:daikita/src/models/sendChatModel.dart';
import 'package:daikita/src/resources/repositories.dart';
import 'package:rxdart/rxdart.dart';

class ChatBloc {
  final _repository = Repositories();
  final _chatListFetcher = PublishSubject<GetChatListModel>();
  final _checkChatDetailFetcher = PublishSubject<GetCheckChatDetailModel>();
  final _chatListDetailFetcher = PublishSubject<GetChatListDetailModel>();
  final _sendChatFetcher = PublishSubject<SendChatModel>();

  PublishSubject<GetChatListModel> get resChatList => _chatListFetcher.stream;

  PublishSubject<GetCheckChatDetailModel> get resCheckChatDetail => _checkChatDetailFetcher.stream;

  PublishSubject<GetChatListDetailModel> get resChatListDetail => _chatListDetailFetcher.stream;

  PublishSubject<SendChatModel> get resSendChat => _sendChatFetcher.stream;

  chatList(String token) async {
    try {
      GetChatListModel getChatListModel = await _repository.chatList(token);
      _chatListFetcher.sink.add(getChatListModel);
    } catch (error) {
      _chatListFetcher.sink.add(error);
    }
  }

  checkChatDetail(String token, String email) async {
    try {
      GetCheckChatDetailModel getCheckChatDetailModel = await _repository.checkChatDetail(token, email);
      _checkChatDetailFetcher.sink.add(getCheckChatDetailModel);
    } catch (error) {
      _checkChatDetailFetcher.sink.add(error);
    }
  }

  chatListDetail(String token, String email, String topik) async {
    try {
      GetChatListDetailModel getChatListDetailModel = await _repository.chatListDetail(token, email, topik);
      _chatListDetailFetcher.sink.add(getChatListDetailModel);
    } catch (error) {
      _chatListDetailFetcher.sink.add(error);
    }
  }

  sendChat(String token, String email, String pesan) async {
    try {
      SendChatModel sendChatModel = await _repository.sendChat(token, email, pesan);
      _sendChatFetcher.sink.add(sendChatModel);
    } catch (error) {
      _sendChatFetcher.sink.add(error);
    }
  }

  dispose() {
    _chatListFetcher.close();
    _checkChatDetailFetcher.close();
    _chatListDetailFetcher.close();
    _sendChatFetcher.close();
  }
}

final blocChat = ChatBloc();
