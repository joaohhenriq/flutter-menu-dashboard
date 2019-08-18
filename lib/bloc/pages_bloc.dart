import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class PagesBloc extends BlocBase {

  bool isCollapsed = true;

  final _controller = BehaviorSubject<bool>();
  Stream<bool> get outIsCollapsedStream => _controller.stream;
  Sink<bool> get outIsCollapsedSink => _controller.sink;

  PagesBloc(){
    outIsCollapsedSink.add(isCollapsed);
  }

  void changeCollapse(){
    isCollapsed = !isCollapsed;
    outIsCollapsedSink.add(isCollapsed);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}