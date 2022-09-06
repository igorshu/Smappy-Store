part of 'settings_bloc.dart';

enum Status {
  new_('new'),
  deliveredShop('deliveredShop'),
  completed('completed'),
  canceled('canceled');

  const Status(this.status);
  final String status;
}
