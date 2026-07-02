import 'package:bloc/bloc.dart';

import '../date_formatter.dart';
import 'date_x_event.dart';
import 'date_x_state.dart';

/// BLoC for reactive date conversion and formatting.
class DateXBloc extends Bloc<DateXEvent, DateXState> {
  DateXBloc() : super(const DateXInitial()) {
    on<ConvertDateEvent>(_onConvertDate);
    on<FormatDateTimeEvent>(_onFormatDateTime);
    on<ResetDateXEvent>(_onReset);
  }

  Future<void> _onConvertDate(
    ConvertDateEvent event,
    Emitter<DateXState> emit,
  ) async {
    emit(const DateXLoading());
    try {
      final result = DateFormatter.convert(event.dateString, event.format);
      emit(DateXSuccess(
        result: result,
        inputValue: event.dateString,
        formatUsed: event.format,
      ));
    } catch (e) {
      emit(DateXError(message: e.toString()));
    }
  }

  Future<void> _onFormatDateTime(
    FormatDateTimeEvent event,
    Emitter<DateXState> emit,
  ) async {
    emit(const DateXLoading());
    try {
      final result = DateFormatter.formatDate(event.date, event.outputKey);
      emit(DateXSuccess(
        result: result,
        inputValue: event.date.toIso8601String(),
        formatUsed: event.outputKey,
      ));
    } catch (e) {
      emit(DateXError(message: e.toString()));
    }
  }

  void _onReset(ResetDateXEvent event, Emitter<DateXState> emit) {
    emit(const DateXInitial());
  }
}
