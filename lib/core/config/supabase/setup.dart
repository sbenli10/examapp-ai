import 'package:supabase_flutter/supabase_flutter.dart';

import '../../utils/env/env.dart';

Future<void> setupSupabase() async {
  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
  );
}