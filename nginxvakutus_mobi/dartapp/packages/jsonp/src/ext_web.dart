library json.ext_web;

import 'dart:async';
import 'dart:html';
import 'package:js/js.dart' as js;
import 'external.dart';

class JavascriptImpl extends Javascript {

  const JavascriptImpl();

  /**
   * Makes a callback that will complete the completer with the resulting data.
   */
  void makeOnceCallback(String name, Completer completer) {
    js.context[name] = new js.Callback.once((js.Proxy data) {
      js.retain(data);
      completer.complete(data);
    });
  }

  /**
   * Makes a callback that will populate the stream with the resulting data.
   */
  void makeManyCallback(String name, StreamController stream) {
    js.context[name] = new js.Callback.many((js.Proxy data) {
      js.retain(data);
      stream.add(data);
    });
  }

  /**
   * Releases the named callback.
   */
  void releaseCallback(String name) {
    js.Callback callback = js.context[name];
    if (callback != null) {
      js.context[name] = null;
      callback.dispose();
    }
  }

  /**
   * Releases the json data.
   */
  void releaseData(js.Proxy data) {
    js.release(data);
  }
}

class HtmlImpl extends Html {

  const HtmlImpl();

  /**
   * This adds a script node with a source of the provided url to the dom.
   */
  void request(String url) {
    document.body.nodes.add(new ScriptElement()..src = url);
  }
}
