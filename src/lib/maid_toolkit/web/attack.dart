import 'package:panzer_maid/maid_shell/utils.dart';

Future<int> dns_scanner(List<String> argsv) async {
  var domain = searchKeyValue(argsv, key: 'domain');

  var options = [
    "A +short",
    "AAAA +short",
    "CNAME +short",
    "MX +short",
    "NS +short",
    "TXT +short",
    "SOA +short",
    "SRV +short",
    "PTR +short",
    "DNSKEY +short",
  ];

  for (final opt in options) {
    var out = await flawlessExec("dig $domain $opt");
    if (out != 0) return out;
  }

  return stdint('ok');
}
