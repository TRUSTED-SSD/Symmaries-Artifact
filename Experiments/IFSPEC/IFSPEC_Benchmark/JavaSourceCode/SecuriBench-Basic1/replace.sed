s#@servlet description\s*=\s*\"[^\"]*\"#@servlet description=\"secure version of\"#g
s#@servlet vuln_count\s*=\s*\"[^\"]*\"#@servlet vuln_count=\"0\"#g
s#.*BAD.*##g
s#return [0-9]#return 0#g
s#return \".*\";#return "secure version of"#g
