import 'package:envied/envied.dart';
import 'package:flutter_riverpod_starter/models/models.dart';

part 'env.g.dart';

@Envied(path: '.env.dev', name: 'DevelopEnv', useConstantCase: true)
@Envied(path: '.env.stg', name: 'StagingEnv', useConstantCase: true)
@Envied(path: '.env.prod', name: 'ProductionEnv', useConstantCase: true)
final class Env {
  static late final Flavor flavor;

  factory Env() => _instance;

  static final Env _instance = switch (flavor) {
    Flavor.develop => _DevelopEnv(),
    Flavor.staging => _StagingEnv(),
    Flavor.production => _ProductionEnv(),
  };

  @EnviedField()
  final String baseUrl = _instance.baseUrl;
}
