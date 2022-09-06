import 'package:beamer/beamer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smappy_store/core/api/products/product.dart';
import 'package:smappy_store/logic/auth_bloc/auth_bloc.dart';
import 'package:smappy_store/ui/navigation/beam_pages.dart';
import 'package:smappy_store/ui/navigation/routes.dart';

class SmappyBeamerDelegate extends BeamerDelegate {

  SmappyBeamerDelegate(String? token) : super(
      initialPath: token?.isEmpty ?? true ? Routes.initial : Routes.loggedIn,
      guards: [
        BeamGuard(
          pathPatterns: [RegExp(Routes.settings), RegExp(Routes.shop), RegExp(Routes.product)],
          check: (context, location) => context.read<AuthBloc>().state.isLoggedIn,
          beamToNamed: (origin, target) => Routes.welcome,
          replaceCurrentStack: true,
        )
      ],
      locationBuilder: RoutesLocationBuilder(
        routes: {
          Routes.welcome: (context, state, data) => BeamPages.welcome,
          Routes.login: (context, state, data) => BeamPages.login,
          Routes.smappy: (context, state, data) => BeamPages.smappy,
          Routes.registration: (context, state, data) => BeamPages.registration(state, data),
          Routes.shop: (context, state, data) => BeamPages.shop,
          Routes.product: (context, state, data) => BeamPages.product(data as Product),
          Routes.settings: (context, state, data) => BeamPages.settings,
        },
      )
  );
}
