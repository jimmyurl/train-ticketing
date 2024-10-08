// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a sw locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'sw';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appTitle": MessageLookupByLibrary.simpleMessage("Mpangilio wa Safari"),
        "bus": MessageLookupByLibrary.simpleMessage("Basi"),
        "departure": MessageLookupByLibrary.simpleMessage("Kuondoka"),
        "flight": MessageLookupByLibrary.simpleMessage("Ndege"),
        "fromHint": MessageLookupByLibrary.simpleMessage("Kutoka (Kuondoka)"),
        "home": MessageLookupByLibrary.simpleMessage("Nyumbani"),
        "hotels": MessageLookupByLibrary.simpleMessage("Hoteli"),
        "planYourJourney": MessageLookupByLibrary.simpleMessage(
            "Panga safari yako kwa urahisi..."),
        "profile": MessageLookupByLibrary.simpleMessage("Wasifu"),
        "roundTrip":
            MessageLookupByLibrary.simpleMessage("Safari ya Kwenda na Kurudi"),
        "saved": MessageLookupByLibrary.simpleMessage("Zilizohifadhiwa"),
        "search": MessageLookupByLibrary.simpleMessage("Tafuta"),
        "selectDepartureDate":
            MessageLookupByLibrary.simpleMessage("Chagua tarehe ya kuondoka"),
        "selectReturnDate":
            MessageLookupByLibrary.simpleMessage("Chagua tarehe ya kurudi"),
        "toHint": MessageLookupByLibrary.simpleMessage("Kwenda (Kifiko)"),
        "trains": MessageLookupByLibrary.simpleMessage("Treni")
      };
}
