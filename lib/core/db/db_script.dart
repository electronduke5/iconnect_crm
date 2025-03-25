part 'db_select_requests.dart';

abstract class DatabaseRequest {
  static const String dbName = 'iConnectCRM.db';

  //Названия таблиц
  static const String tableCategories = 'categories';
  static const String tableProducts = 'products';
  static const String tablePhones = 'phones';
  static const String tableCheques = 'cheques';
  static const String tableEmployees = 'employees';

  //Лист с названиями таблиц
  static const List<String> tablesList = [
    tableCategories,
    tableEmployees,
    tablePhones,
    tableCheques,
    tableProducts,
  ];

  /// Лист с командами по созданию таблиц
  static const List<String> tableCreateList = [
    _createTableCategories,
    _createTableEmployees,
    _createTablePhones,
    _createTableCheques,
    _createTableProducts,
  ];

  static const String _createTableCategories =
      'CREATE  TABLE $tableCategories ('
      'id integer not null primary key,'
      'title text unique not null);';

  static const String _createTableEmployees =
      'CREATE TABLE $tableEmployees ('
      'id integer not null primary key,'
      'surname text not null,'
      'name text not null,'
      'patronymic text,'
      'post text not null);';

  static const String _createTablePhones =
      'CREATE TABLE $tablePhones ('
      'id integer not null primary key,'
      'color text not null,'
      'battery_status integer not null);';

  static const String _createTableCheques =
      'CREATE TABLE $tableCheques ('
      'id integer not null primary key,'
      'date text not null,'
      'total_cost integer not null,'
      'total_discount integer,'
      'employee_id integer not null,'
      'foreign key (employee_id) references $tableEmployees(id));';

  static const String _createTableProducts =
      'CREATE TABLE $tableProducts ('
      'id integer not null primary key,'
      'title text not null,'
      'serial_number text,'
      'count integer,'
      'warranty_count integer,'
      'purchase_price integer not null,'
      'sale_price integer,'
      'profit integer,'
      'date_of_purchase text,'
      'date_of_sale text,'
      'category_id integer not null,'
      'phone_id integer,'
      'cheque_id integer,'
      'foreign key (phone_id) REFERENCES $tablePhones(id),'
      'foreign key (cheque_id) REFERENCES $tableCheques(id),'
      'foreign key (category_id) REFERENCES $tableCategories(id));';

  static String deleteTable(String table) => 'DROP TABLE $table';

}
