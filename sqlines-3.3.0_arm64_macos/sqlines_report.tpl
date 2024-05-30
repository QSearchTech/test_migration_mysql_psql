<html>
<style type="text/css">
body { font-family: verdana; }
h1 { font-family: trebuchet ms, verdana; font-size: 20px; color: #000000; border-bottom:1px solid grey; }
h2 { font-family: trebuchet ms, verdana; font-size: 18px; color: #000000; border-bottom:1px solid grey; }
p { font-size: 13px; }
table { font-size: 13px; border: 1px solid; border-collapse:collapse; }
tr:hover td { background-color: #A4BBFE; }
th { background: #FFFFFF; padding: 0px 10px 0px 10px; border: 1px solid grey; }
td { padding: 0px 10px 0px 10px; border: 1px solid grey; }
.td_warn { background:yellow; }
.td_error { background:lightpink; }
a:link { text-decoration: none; color: #0000A0;}
a:visited { text-decoration: none; color: #0000A0;}
a:active { text-decoration: none; color: #0000A0;}
a:hover { text-decoration: none; color: #800517;}
</style>

<head>
<title>SQLines Report</title>
</head>

<body>
<h1>SQLines Report</h1>
<p><?summary?></p>

<!------------------------------->
<?ifexists:datatypes_table?>
<h2>Data Types</h2>

<p>All built-in data types:</p><?datatypes_table?>
  <?ifexists:datatype_dtl_table?><p>Built-in data type conversion details:</p><?datatype_dtl_table?><?/ifexists:datatype_dtl_table?>
  <?ifexists:udt_datatypes_table?><p>All derived and user-defined (UDT) data types:</p><?udt_datatypes_table?><?/ifexists:udt_datatypes_table?>
  <?ifexists:udt_datatype_dtl_table?><p>Derived and user-defined (UDT) data type details:</p><?udt_datatype_dtl_table?><?/ifexists:udt_datatype_dtl_table?>
<?/ifexists:datatypes_table?>

<!------------------------------->
<?ifexists:builtin_func_table?>
<h2>Functions</h2>

<p>All built-in functions:</p><?builtin_func_table?>
  <?ifexists:builtin_func_dtl_table?><p>Built-in function details:</p><?builtin_func_dtl_table?><?/ifexists:builtin_func_dtl_table?>
<?/ifexists:builtin_func_table?>

<?ifexists:udf_func_table?><p>All user-defined functions:</p><?udf_func_table?><?/ifexists:udf_func_table?>

<!------------------------------->
<?ifexists:seq_table?>
<h2>Sequences</h2>

<p>Sequence statements:</p><?seq_table?>
  <?ifexists:seq_dtl_table?><p>Sequence options:</p><?seq_dtl_table?><?/ifexists:seq_dtl_table?>
  <?ifexists:seq_opt_dtl_table?><p>Sequence option details:</p><?seq_opt_dtl_table?><?/ifexists:seq_opt_dtl_table?>
  <?ifexists:seq_ref_table?><p>Sequence references:</p><?seq_ref_table?><?/ifexists:seq_ref_table?>
  <?ifexists:seq_ref_dtl_table?><p>Sequence reference details:</p><?seq_ref_dtl_table?><?/ifexists:seq_ref_dtl_table?>
<?/ifexists:seq_table?>

<!------------------------------->
<?ifexists:system_proc_table?>
<h2>Procedures</h2>

<p>All system procedures calls:</p><?system_proc_table?>
<p>System procedure call details:</p><?system_proc_dtl_table?>
<?/ifexists:system_proc_table?>

<!------------------------------->
<?ifexists:statements_table?>
<h2>Statements</h2>

<p>All SQL statements:</p><?statements_table?>
  <?ifexists:crtab_stmt_table?><p>CREATE TABLE statements details:</p><?crtab_stmt_table?><?/ifexists:crtab_stmt_table?>
  <?ifexists:alttab_stmt_table?><p>ALTER TABLE statements details:</p><?alttab_stmt_table?><?/ifexists:alttab_stmt_table?>
  <?ifexists:cridx_stmt_table?><p>CREATE INDEX statements details:</p><?cridx_stmt_table?><?/ifexists:cridx_stmt_table?>
  <?ifexists:select_stmt_table?><p>SELECT statements details:</p><?select_stmt_table?><?/ifexists:select_stmt_table?>
  <?ifexists:crproc_stmt_table?><p>CREATE PROCEDURE statements details:</p><?crproc_stmt_table?><?/ifexists:crproc_stmt_table?>
  <?ifexists:othersql_stmt_table?><p>Other SQL statements details:</p><?othersql_stmt_table?><?/ifexists:othersql_stmt_table?>
<?/ifexists:statements_table?>

<!------------------------------->
<?ifexists:pl_statements?>
<h2>Procedural Language Statements</h2>

<p>All procedural SQL statements and constructs:</p><?pl_statements?>
  <?ifexists:pl_statements_exceptions?><p>Predefined exception handlers:</p><?pl_statements_exceptions?><?/ifexists:pl_statements_exceptions?>
<?/ifexists:pl_statements?>

<!------------------------------->
<?ifexists:packages?>
<h2>Built-in Packages</h2>

<p>All built-in packages:</p><?packages?>
  <?ifexists:pkg_statements_items?><p>Built-in packages functions, procedures and constants:</p><?pkg_statements_items?><?/ifexists:pkg_statements_items?>
<?/ifexists:packages?>

<!------------------------------->
<?ifexists:database_conf?>
<h2>Database Configuration</h2>

<p>Database configuration settings:</p><?database_conf?>
<?/ifexists:database_conf?>

<!------------------------------->
<?ifexists:nonascii_idents?>
<h2>Special Characters in Identifiers</h2>

<p>All identifiers having special characters (non 7-bit ASCII):</p><?nonascii_idents?>
<?/ifexists:nonascii_idents?>

</body>
</html>