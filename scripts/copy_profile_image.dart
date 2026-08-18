import 'dart:io';

void main() {
  const source =
      '/Users/ahmedehabmohammed/.cursor/projects/Users-ahmedehabmohammed-Developer-myportofilo/assets/ahmed-0192bef5-2cb3-4109-a107-d05cb7960e49.png';
  const dest =
      '/Users/ahmedehabmohammed/Developer/myportofilo/assets/images/ahmed_profile.png';
  File(source).copySync(dest);
  stdout.writeln('OK ${File(dest).lengthSync()} bytes');
}
