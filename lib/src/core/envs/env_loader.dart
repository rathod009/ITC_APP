import '../logs/custom_logger.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart' as dtv;

import 'env_datas.dart';

class EnvLoader {
  static Future<Map<String, String>> load({required dtv.DotEnv dotEnv}) async {
    AppLogger.instance.logger.i("🔹 INIT ENV LOADER");
    //
    await dotEnv.load(fileName: "${EnvDatas.envsFolder}/.env.${EnvDatas.all}");
    AppLogger.instance.logger.i("🔹 ENV ALL => ${dotEnv.env['ENV']}");
    String env = dotEnv.env['ENV'] ?? EnvDatas.defaultEnv; // Defaut Env
    AppLogger.instance.logger.i("🔹 ENV => $env");
    //
    await dotEnv.load(fileName: "${EnvDatas.envsFolder}/.env.$env");
    AppLogger.instance.logger.i("🔹 ENV LOADED => $env");
    return dotEnv.env;
  }
}
