// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ImagesTable extends Images with TableInfo<$ImagesTable, Image> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createAtMeta = const VerificationMeta(
    'createAt',
  );
  @override
  late final GeneratedColumn<DateTime> createAt = GeneratedColumn<DateTime>(
    'create_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _descMeta = const VerificationMeta('desc');
  @override
  late final GeneratedColumn<String> desc = GeneratedColumn<String>(
    'desc',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
    'path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, createAt, desc, path];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'images';
  @override
  VerificationContext validateIntegrity(
    Insertable<Image> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(
        _createAtMeta,
        createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta),
      );
    }
    if (data.containsKey('desc')) {
      context.handle(
        _descMeta,
        desc.isAcceptableOrUnknown(data['desc']!, _descMeta),
      );
    }
    if (data.containsKey('path')) {
      context.handle(
        _pathMeta,
        path.isAcceptableOrUnknown(data['path']!, _pathMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Image map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Image(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}create_at'],
      )!,
      desc: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}desc'],
      ),
      path: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}path'],
      ),
    );
  }

  @override
  $ImagesTable createAlias(String alias) {
    return $ImagesTable(attachedDatabase, alias);
  }
}

class Image extends DataClass implements Insertable<Image> {
  final int id;
  final String name;
  final DateTime createAt;
  final String? desc;
  final String? path;
  const Image({
    required this.id,
    required this.name,
    required this.createAt,
    this.desc,
    this.path,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['create_at'] = Variable<DateTime>(createAt);
    if (!nullToAbsent || desc != null) {
      map['desc'] = Variable<String>(desc);
    }
    if (!nullToAbsent || path != null) {
      map['path'] = Variable<String>(path);
    }
    return map;
  }

  ImagesCompanion toCompanion(bool nullToAbsent) {
    return ImagesCompanion(
      id: Value(id),
      name: Value(name),
      createAt: Value(createAt),
      desc: desc == null && nullToAbsent ? const Value.absent() : Value(desc),
      path: path == null && nullToAbsent ? const Value.absent() : Value(path),
    );
  }

  factory Image.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Image(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
      desc: serializer.fromJson<String?>(json['desc']),
      path: serializer.fromJson<String?>(json['path']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'createAt': serializer.toJson<DateTime>(createAt),
      'desc': serializer.toJson<String?>(desc),
      'path': serializer.toJson<String?>(path),
    };
  }

  Image copyWith({
    int? id,
    String? name,
    DateTime? createAt,
    Value<String?> desc = const Value.absent(),
    Value<String?> path = const Value.absent(),
  }) => Image(
    id: id ?? this.id,
    name: name ?? this.name,
    createAt: createAt ?? this.createAt,
    desc: desc.present ? desc.value : this.desc,
    path: path.present ? path.value : this.path,
  );
  Image copyWithCompanion(ImagesCompanion data) {
    return Image(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
      desc: data.desc.present ? data.desc.value : this.desc,
      path: data.path.present ? data.path.value : this.path,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Image(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createAt: $createAt, ')
          ..write('desc: $desc, ')
          ..write('path: $path')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createAt, desc, path);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Image &&
          other.id == this.id &&
          other.name == this.name &&
          other.createAt == this.createAt &&
          other.desc == this.desc &&
          other.path == this.path);
}

class ImagesCompanion extends UpdateCompanion<Image> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> createAt;
  final Value<String?> desc;
  final Value<String?> path;
  const ImagesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createAt = const Value.absent(),
    this.desc = const Value.absent(),
    this.path = const Value.absent(),
  });
  ImagesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.createAt = const Value.absent(),
    this.desc = const Value.absent(),
    this.path = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Image> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? createAt,
    Expression<String>? desc,
    Expression<String>? path,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createAt != null) 'create_at': createAt,
      if (desc != null) 'desc': desc,
      if (path != null) 'path': path,
    });
  }

  ImagesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<DateTime>? createAt,
    Value<String?>? desc,
    Value<String?>? path,
  }) {
    return ImagesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createAt: createAt ?? this.createAt,
      desc: desc ?? this.desc,
      path: path ?? this.path,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    if (desc.present) {
      map['desc'] = Variable<String>(desc.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImagesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createAt: $createAt, ')
          ..write('desc: $desc, ')
          ..write('path: $path')
          ..write(')'))
        .toString();
  }
}

class $AiProvidersTable extends AiProviders
    with TableInfo<$AiProvidersTable, AiProvider> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiProvidersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _baseUrlMeta = const VerificationMeta(
    'baseUrl',
  );
  @override
  late final GeneratedColumn<String> baseUrl = GeneratedColumn<String>(
    'base_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _apiKeyMeta = const VerificationMeta('apiKey');
  @override
  late final GeneratedColumn<String> apiKey = GeneratedColumn<String>(
    'api_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconIdMeta = const VerificationMeta('iconId');
  @override
  late final GeneratedColumn<int> iconId = GeneratedColumn<int>(
    'icon_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES images (id)',
    ),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _modelsJsonMeta = const VerificationMeta(
    'modelsJson',
  );
  @override
  late final GeneratedColumn<String> modelsJson = GeneratedColumn<String>(
    'models_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    baseUrl,
    apiKey,
    iconId,
    isActive,
    createdAt,
    modelsJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_providers';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiProvider> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('base_url')) {
      context.handle(
        _baseUrlMeta,
        baseUrl.isAcceptableOrUnknown(data['base_url']!, _baseUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_baseUrlMeta);
    }
    if (data.containsKey('api_key')) {
      context.handle(
        _apiKeyMeta,
        apiKey.isAcceptableOrUnknown(data['api_key']!, _apiKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_apiKeyMeta);
    }
    if (data.containsKey('icon_id')) {
      context.handle(
        _iconIdMeta,
        iconId.isAcceptableOrUnknown(data['icon_id']!, _iconIdMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('models_json')) {
      context.handle(
        _modelsJsonMeta,
        modelsJson.isAcceptableOrUnknown(data['models_json']!, _modelsJsonMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiProvider map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiProvider(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      baseUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_url'],
      )!,
      apiKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}api_key'],
      )!,
      iconId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}icon_id'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      modelsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}models_json'],
      )!,
    );
  }

  @override
  $AiProvidersTable createAlias(String alias) {
    return $AiProvidersTable(attachedDatabase, alias);
  }
}

class AiProvider extends DataClass implements Insertable<AiProvider> {
  final int id;
  final String name;
  final String? description;
  final String baseUrl;
  final String apiKey;
  final int? iconId;
  final bool isActive;
  final DateTime createdAt;
  final String modelsJson;
  const AiProvider({
    required this.id,
    required this.name,
    this.description,
    required this.baseUrl,
    required this.apiKey,
    this.iconId,
    required this.isActive,
    required this.createdAt,
    required this.modelsJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['base_url'] = Variable<String>(baseUrl);
    map['api_key'] = Variable<String>(apiKey);
    if (!nullToAbsent || iconId != null) {
      map['icon_id'] = Variable<int>(iconId);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['models_json'] = Variable<String>(modelsJson);
    return map;
  }

  AiProvidersCompanion toCompanion(bool nullToAbsent) {
    return AiProvidersCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      baseUrl: Value(baseUrl),
      apiKey: Value(apiKey),
      iconId: iconId == null && nullToAbsent
          ? const Value.absent()
          : Value(iconId),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      modelsJson: Value(modelsJson),
    );
  }

  factory AiProvider.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiProvider(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      baseUrl: serializer.fromJson<String>(json['baseUrl']),
      apiKey: serializer.fromJson<String>(json['apiKey']),
      iconId: serializer.fromJson<int?>(json['iconId']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      modelsJson: serializer.fromJson<String>(json['modelsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'baseUrl': serializer.toJson<String>(baseUrl),
      'apiKey': serializer.toJson<String>(apiKey),
      'iconId': serializer.toJson<int?>(iconId),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'modelsJson': serializer.toJson<String>(modelsJson),
    };
  }

  AiProvider copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    String? baseUrl,
    String? apiKey,
    Value<int?> iconId = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    String? modelsJson,
  }) => AiProvider(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    baseUrl: baseUrl ?? this.baseUrl,
    apiKey: apiKey ?? this.apiKey,
    iconId: iconId.present ? iconId.value : this.iconId,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    modelsJson: modelsJson ?? this.modelsJson,
  );
  AiProvider copyWithCompanion(AiProvidersCompanion data) {
    return AiProvider(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      baseUrl: data.baseUrl.present ? data.baseUrl.value : this.baseUrl,
      apiKey: data.apiKey.present ? data.apiKey.value : this.apiKey,
      iconId: data.iconId.present ? data.iconId.value : this.iconId,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      modelsJson: data.modelsJson.present
          ? data.modelsJson.value
          : this.modelsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiProvider(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('apiKey: $apiKey, ')
          ..write('iconId: $iconId, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('modelsJson: $modelsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    baseUrl,
    apiKey,
    iconId,
    isActive,
    createdAt,
    modelsJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiProvider &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.baseUrl == this.baseUrl &&
          other.apiKey == this.apiKey &&
          other.iconId == this.iconId &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.modelsJson == this.modelsJson);
}

class AiProvidersCompanion extends UpdateCompanion<AiProvider> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> baseUrl;
  final Value<String> apiKey;
  final Value<int?> iconId;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<String> modelsJson;
  const AiProvidersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.baseUrl = const Value.absent(),
    this.apiKey = const Value.absent(),
    this.iconId = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.modelsJson = const Value.absent(),
  });
  AiProvidersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required String baseUrl,
    required String apiKey,
    this.iconId = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.modelsJson = const Value.absent(),
  }) : name = Value(name),
       baseUrl = Value(baseUrl),
       apiKey = Value(apiKey);
  static Insertable<AiProvider> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? baseUrl,
    Expression<String>? apiKey,
    Expression<int>? iconId,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<String>? modelsJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (baseUrl != null) 'base_url': baseUrl,
      if (apiKey != null) 'api_key': apiKey,
      if (iconId != null) 'icon_id': iconId,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (modelsJson != null) 'models_json': modelsJson,
    });
  }

  AiProvidersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String>? baseUrl,
    Value<String>? apiKey,
    Value<int?>? iconId,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<String>? modelsJson,
  }) {
    return AiProvidersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      baseUrl: baseUrl ?? this.baseUrl,
      apiKey: apiKey ?? this.apiKey,
      iconId: iconId ?? this.iconId,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      modelsJson: modelsJson ?? this.modelsJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (baseUrl.present) {
      map['base_url'] = Variable<String>(baseUrl.value);
    }
    if (apiKey.present) {
      map['api_key'] = Variable<String>(apiKey.value);
    }
    if (iconId.present) {
      map['icon_id'] = Variable<int>(iconId.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (modelsJson.present) {
      map['models_json'] = Variable<String>(modelsJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiProvidersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('apiKey: $apiKey, ')
          ..write('iconId: $iconId, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('modelsJson: $modelsJson')
          ..write(')'))
        .toString();
  }
}

class $SessionTable extends Session with TableInfo<$SessionTable, SessionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'session';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SessionTable createAlias(String alias) {
    return $SessionTable(attachedDatabase, alias);
  }
}

class SessionData extends DataClass implements Insertable<SessionData> {
  final int id;
  final String? title;
  final DateTime createdAt;
  const SessionData({required this.id, this.title, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SessionCompanion toCompanion(bool nullToAbsent) {
    return SessionCompanion(
      id: Value(id),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      createdAt: Value(createdAt),
    );
  }

  factory SessionData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String?>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SessionData copyWith({
    int? id,
    Value<String?> title = const Value.absent(),
    DateTime? createdAt,
  }) => SessionData(
    id: id ?? this.id,
    title: title.present ? title.value : this.title,
    createdAt: createdAt ?? this.createdAt,
  );
  SessionData copyWithCompanion(SessionCompanion data) {
    return SessionData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionData &&
          other.id == this.id &&
          other.title == this.title &&
          other.createdAt == this.createdAt);
}

class SessionCompanion extends UpdateCompanion<SessionData> {
  final Value<int> id;
  final Value<String?> title;
  final Value<DateTime> createdAt;
  const SessionCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SessionCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<SessionData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SessionCompanion copyWith({
    Value<int>? id,
    Value<String?>? title,
    Value<DateTime>? createdAt,
  }) {
    return SessionCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AiHistoriesTable extends AiHistories
    with TableInfo<$AiHistoriesTable, AiHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiHistoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<int> sourceId = GeneratedColumn<int>(
    'source_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ai_histories (id)',
    ),
  );
  static const VerificationMeta _providerIdMeta = const VerificationMeta(
    'providerId',
  );
  @override
  late final GeneratedColumn<int> providerId = GeneratedColumn<int>(
    'provider_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ai_providers (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Roles, String> role =
      GeneratedColumn<String>(
        'role',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Roles>($AiHistoriesTable.$converterrole);
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES session (id)',
    ),
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toolCallsMeta = const VerificationMeta(
    'toolCalls',
  );
  @override
  late final GeneratedColumn<String> toolCalls = GeneratedColumn<String>(
    'tool_calls',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _toolCallIdMeta = const VerificationMeta(
    'toolCallId',
  );
  @override
  late final GeneratedColumn<String> toolCallId = GeneratedColumn<String>(
    'tool_call_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tokensMeta = const VerificationMeta('tokens');
  @override
  late final GeneratedColumn<int> tokens = GeneratedColumn<int>(
    'tokens',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sourceId,
    providerId,
    role,
    sessionId,
    content,
    toolCalls,
    toolCallId,
    tokens,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_histories';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiHistory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    }
    if (data.containsKey('provider_id')) {
      context.handle(
        _providerIdMeta,
        providerId.isAcceptableOrUnknown(data['provider_id']!, _providerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('tool_calls')) {
      context.handle(
        _toolCallsMeta,
        toolCalls.isAcceptableOrUnknown(data['tool_calls']!, _toolCallsMeta),
      );
    }
    if (data.containsKey('tool_call_id')) {
      context.handle(
        _toolCallIdMeta,
        toolCallId.isAcceptableOrUnknown(
          data['tool_call_id']!,
          _toolCallIdMeta,
        ),
      );
    }
    if (data.containsKey('tokens')) {
      context.handle(
        _tokensMeta,
        tokens.isAcceptableOrUnknown(data['tokens']!, _tokensMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiHistory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiHistory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}source_id'],
      ),
      providerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}provider_id'],
      )!,
      role: $AiHistoriesTable.$converterrole.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}role'],
        )!,
      ),
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      toolCalls: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tool_calls'],
      ),
      toolCallId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tool_call_id'],
      ),
      tokens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tokens'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AiHistoriesTable createAlias(String alias) {
    return $AiHistoriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Roles, String, String> $converterrole =
      EnumNameConverter(Roles.values);
}

class AiHistory extends DataClass implements Insertable<AiHistory> {
  final int id;

  /// 该字段不为空是表示这是对id为sourceId的记录的覆写
  final int? sourceId;
  final int providerId;
  final Roles role;
  final int sessionId;
  final String content;
  final String? toolCalls;
  final String? toolCallId;
  final int? tokens;
  final DateTime createdAt;
  const AiHistory({
    required this.id,
    this.sourceId,
    required this.providerId,
    required this.role,
    required this.sessionId,
    required this.content,
    this.toolCalls,
    this.toolCallId,
    this.tokens,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || sourceId != null) {
      map['source_id'] = Variable<int>(sourceId);
    }
    map['provider_id'] = Variable<int>(providerId);
    {
      map['role'] = Variable<String>(
        $AiHistoriesTable.$converterrole.toSql(role),
      );
    }
    map['session_id'] = Variable<int>(sessionId);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || toolCalls != null) {
      map['tool_calls'] = Variable<String>(toolCalls);
    }
    if (!nullToAbsent || toolCallId != null) {
      map['tool_call_id'] = Variable<String>(toolCallId);
    }
    if (!nullToAbsent || tokens != null) {
      map['tokens'] = Variable<int>(tokens);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AiHistoriesCompanion toCompanion(bool nullToAbsent) {
    return AiHistoriesCompanion(
      id: Value(id),
      sourceId: sourceId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceId),
      providerId: Value(providerId),
      role: Value(role),
      sessionId: Value(sessionId),
      content: Value(content),
      toolCalls: toolCalls == null && nullToAbsent
          ? const Value.absent()
          : Value(toolCalls),
      toolCallId: toolCallId == null && nullToAbsent
          ? const Value.absent()
          : Value(toolCallId),
      tokens: tokens == null && nullToAbsent
          ? const Value.absent()
          : Value(tokens),
      createdAt: Value(createdAt),
    );
  }

  factory AiHistory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiHistory(
      id: serializer.fromJson<int>(json['id']),
      sourceId: serializer.fromJson<int?>(json['sourceId']),
      providerId: serializer.fromJson<int>(json['providerId']),
      role: $AiHistoriesTable.$converterrole.fromJson(
        serializer.fromJson<String>(json['role']),
      ),
      sessionId: serializer.fromJson<int>(json['sessionId']),
      content: serializer.fromJson<String>(json['content']),
      toolCalls: serializer.fromJson<String?>(json['toolCalls']),
      toolCallId: serializer.fromJson<String?>(json['toolCallId']),
      tokens: serializer.fromJson<int?>(json['tokens']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sourceId': serializer.toJson<int?>(sourceId),
      'providerId': serializer.toJson<int>(providerId),
      'role': serializer.toJson<String>(
        $AiHistoriesTable.$converterrole.toJson(role),
      ),
      'sessionId': serializer.toJson<int>(sessionId),
      'content': serializer.toJson<String>(content),
      'toolCalls': serializer.toJson<String?>(toolCalls),
      'toolCallId': serializer.toJson<String?>(toolCallId),
      'tokens': serializer.toJson<int?>(tokens),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AiHistory copyWith({
    int? id,
    Value<int?> sourceId = const Value.absent(),
    int? providerId,
    Roles? role,
    int? sessionId,
    String? content,
    Value<String?> toolCalls = const Value.absent(),
    Value<String?> toolCallId = const Value.absent(),
    Value<int?> tokens = const Value.absent(),
    DateTime? createdAt,
  }) => AiHistory(
    id: id ?? this.id,
    sourceId: sourceId.present ? sourceId.value : this.sourceId,
    providerId: providerId ?? this.providerId,
    role: role ?? this.role,
    sessionId: sessionId ?? this.sessionId,
    content: content ?? this.content,
    toolCalls: toolCalls.present ? toolCalls.value : this.toolCalls,
    toolCallId: toolCallId.present ? toolCallId.value : this.toolCallId,
    tokens: tokens.present ? tokens.value : this.tokens,
    createdAt: createdAt ?? this.createdAt,
  );
  AiHistory copyWithCompanion(AiHistoriesCompanion data) {
    return AiHistory(
      id: data.id.present ? data.id.value : this.id,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
      role: data.role.present ? data.role.value : this.role,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      content: data.content.present ? data.content.value : this.content,
      toolCalls: data.toolCalls.present ? data.toolCalls.value : this.toolCalls,
      toolCallId: data.toolCallId.present
          ? data.toolCallId.value
          : this.toolCallId,
      tokens: data.tokens.present ? data.tokens.value : this.tokens,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiHistory(')
          ..write('id: $id, ')
          ..write('sourceId: $sourceId, ')
          ..write('providerId: $providerId, ')
          ..write('role: $role, ')
          ..write('sessionId: $sessionId, ')
          ..write('content: $content, ')
          ..write('toolCalls: $toolCalls, ')
          ..write('toolCallId: $toolCallId, ')
          ..write('tokens: $tokens, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sourceId,
    providerId,
    role,
    sessionId,
    content,
    toolCalls,
    toolCallId,
    tokens,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiHistory &&
          other.id == this.id &&
          other.sourceId == this.sourceId &&
          other.providerId == this.providerId &&
          other.role == this.role &&
          other.sessionId == this.sessionId &&
          other.content == this.content &&
          other.toolCalls == this.toolCalls &&
          other.toolCallId == this.toolCallId &&
          other.tokens == this.tokens &&
          other.createdAt == this.createdAt);
}

class AiHistoriesCompanion extends UpdateCompanion<AiHistory> {
  final Value<int> id;
  final Value<int?> sourceId;
  final Value<int> providerId;
  final Value<Roles> role;
  final Value<int> sessionId;
  final Value<String> content;
  final Value<String?> toolCalls;
  final Value<String?> toolCallId;
  final Value<int?> tokens;
  final Value<DateTime> createdAt;
  const AiHistoriesCompanion({
    this.id = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.providerId = const Value.absent(),
    this.role = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.content = const Value.absent(),
    this.toolCalls = const Value.absent(),
    this.toolCallId = const Value.absent(),
    this.tokens = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AiHistoriesCompanion.insert({
    this.id = const Value.absent(),
    this.sourceId = const Value.absent(),
    required int providerId,
    required Roles role,
    required int sessionId,
    required String content,
    this.toolCalls = const Value.absent(),
    this.toolCallId = const Value.absent(),
    this.tokens = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : providerId = Value(providerId),
       role = Value(role),
       sessionId = Value(sessionId),
       content = Value(content);
  static Insertable<AiHistory> custom({
    Expression<int>? id,
    Expression<int>? sourceId,
    Expression<int>? providerId,
    Expression<String>? role,
    Expression<int>? sessionId,
    Expression<String>? content,
    Expression<String>? toolCalls,
    Expression<String>? toolCallId,
    Expression<int>? tokens,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceId != null) 'source_id': sourceId,
      if (providerId != null) 'provider_id': providerId,
      if (role != null) 'role': role,
      if (sessionId != null) 'session_id': sessionId,
      if (content != null) 'content': content,
      if (toolCalls != null) 'tool_calls': toolCalls,
      if (toolCallId != null) 'tool_call_id': toolCallId,
      if (tokens != null) 'tokens': tokens,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AiHistoriesCompanion copyWith({
    Value<int>? id,
    Value<int?>? sourceId,
    Value<int>? providerId,
    Value<Roles>? role,
    Value<int>? sessionId,
    Value<String>? content,
    Value<String?>? toolCalls,
    Value<String?>? toolCallId,
    Value<int?>? tokens,
    Value<DateTime>? createdAt,
  }) {
    return AiHistoriesCompanion(
      id: id ?? this.id,
      sourceId: sourceId ?? this.sourceId,
      providerId: providerId ?? this.providerId,
      role: role ?? this.role,
      sessionId: sessionId ?? this.sessionId,
      content: content ?? this.content,
      toolCalls: toolCalls ?? this.toolCalls,
      toolCallId: toolCallId ?? this.toolCallId,
      tokens: tokens ?? this.tokens,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<int>(sourceId.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<int>(providerId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(
        $AiHistoriesTable.$converterrole.toSql(role.value),
      );
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (toolCalls.present) {
      map['tool_calls'] = Variable<String>(toolCalls.value);
    }
    if (toolCallId.present) {
      map['tool_call_id'] = Variable<String>(toolCallId.value);
    }
    if (tokens.present) {
      map['tokens'] = Variable<int>(tokens.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiHistoriesCompanion(')
          ..write('id: $id, ')
          ..write('sourceId: $sourceId, ')
          ..write('providerId: $providerId, ')
          ..write('role: $role, ')
          ..write('sessionId: $sessionId, ')
          ..write('content: $content, ')
          ..write('toolCalls: $toolCalls, ')
          ..write('toolCallId: $toolCallId, ')
          ..write('tokens: $tokens, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PromptsTable extends Prompts with TableInfo<$PromptsTable, Prompt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PromptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descMeta = const VerificationMeta('desc');
  @override
  late final GeneratedColumn<String> desc = GeneratedColumn<String>(
    'desc',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, desc, content];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prompts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Prompt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('desc')) {
      context.handle(
        _descMeta,
        desc.isAcceptableOrUnknown(data['desc']!, _descMeta),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Prompt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Prompt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      desc: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}desc'],
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
    );
  }

  @override
  $PromptsTable createAlias(String alias) {
    return $PromptsTable(attachedDatabase, alias);
  }
}

class Prompt extends DataClass implements Insertable<Prompt> {
  final int id;
  final String? name;
  final String? desc;

  /// 使用{{key}}添加可被替换内容
  final String content;
  const Prompt({required this.id, this.name, this.desc, required this.content});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || desc != null) {
      map['desc'] = Variable<String>(desc);
    }
    map['content'] = Variable<String>(content);
    return map;
  }

  PromptsCompanion toCompanion(bool nullToAbsent) {
    return PromptsCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      desc: desc == null && nullToAbsent ? const Value.absent() : Value(desc),
      content: Value(content),
    );
  }

  factory Prompt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Prompt(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      desc: serializer.fromJson<String?>(json['desc']),
      content: serializer.fromJson<String>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'desc': serializer.toJson<String?>(desc),
      'content': serializer.toJson<String>(content),
    };
  }

  Prompt copyWith({
    int? id,
    Value<String?> name = const Value.absent(),
    Value<String?> desc = const Value.absent(),
    String? content,
  }) => Prompt(
    id: id ?? this.id,
    name: name.present ? name.value : this.name,
    desc: desc.present ? desc.value : this.desc,
    content: content ?? this.content,
  );
  Prompt copyWithCompanion(PromptsCompanion data) {
    return Prompt(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      desc: data.desc.present ? data.desc.value : this.desc,
      content: data.content.present ? data.content.value : this.content,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Prompt(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('desc: $desc, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, desc, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Prompt &&
          other.id == this.id &&
          other.name == this.name &&
          other.desc == this.desc &&
          other.content == this.content);
}

class PromptsCompanion extends UpdateCompanion<Prompt> {
  final Value<int> id;
  final Value<String?> name;
  final Value<String?> desc;
  final Value<String> content;
  const PromptsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.desc = const Value.absent(),
    this.content = const Value.absent(),
  });
  PromptsCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.desc = const Value.absent(),
    required String content,
  }) : content = Value(content);
  static Insertable<Prompt> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? desc,
    Expression<String>? content,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (desc != null) 'desc': desc,
      if (content != null) 'content': content,
    });
  }

  PromptsCompanion copyWith({
    Value<int>? id,
    Value<String?>? name,
    Value<String?>? desc,
    Value<String>? content,
  }) {
    return PromptsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      content: content ?? this.content,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (desc.present) {
      map['desc'] = Variable<String>(desc.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PromptsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('desc: $desc, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }
}

class $AiHistoryImagesLinkTable extends AiHistoryImagesLink
    with TableInfo<$AiHistoryImagesLinkTable, AiHistoryImagesLinkData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiHistoryImagesLinkTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _historyIdMeta = const VerificationMeta(
    'historyId',
  );
  @override
  late final GeneratedColumn<int> historyId = GeneratedColumn<int>(
    'history_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ai_histories (id)',
    ),
  );
  static const VerificationMeta _imageIdMeta = const VerificationMeta(
    'imageId',
  );
  @override
  late final GeneratedColumn<int> imageId = GeneratedColumn<int>(
    'image_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES images (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, historyId, imageId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_history_images_link';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiHistoryImagesLinkData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('history_id')) {
      context.handle(
        _historyIdMeta,
        historyId.isAcceptableOrUnknown(data['history_id']!, _historyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_historyIdMeta);
    }
    if (data.containsKey('image_id')) {
      context.handle(
        _imageIdMeta,
        imageId.isAcceptableOrUnknown(data['image_id']!, _imageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_imageIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiHistoryImagesLinkData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiHistoryImagesLinkData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      historyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}history_id'],
      )!,
      imageId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}image_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AiHistoryImagesLinkTable createAlias(String alias) {
    return $AiHistoryImagesLinkTable(attachedDatabase, alias);
  }
}

class AiHistoryImagesLinkData extends DataClass
    implements Insertable<AiHistoryImagesLinkData> {
  final int id;
  final int historyId;
  final int imageId;
  final DateTime createdAt;
  const AiHistoryImagesLinkData({
    required this.id,
    required this.historyId,
    required this.imageId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['history_id'] = Variable<int>(historyId);
    map['image_id'] = Variable<int>(imageId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AiHistoryImagesLinkCompanion toCompanion(bool nullToAbsent) {
    return AiHistoryImagesLinkCompanion(
      id: Value(id),
      historyId: Value(historyId),
      imageId: Value(imageId),
      createdAt: Value(createdAt),
    );
  }

  factory AiHistoryImagesLinkData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiHistoryImagesLinkData(
      id: serializer.fromJson<int>(json['id']),
      historyId: serializer.fromJson<int>(json['historyId']),
      imageId: serializer.fromJson<int>(json['imageId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'historyId': serializer.toJson<int>(historyId),
      'imageId': serializer.toJson<int>(imageId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AiHistoryImagesLinkData copyWith({
    int? id,
    int? historyId,
    int? imageId,
    DateTime? createdAt,
  }) => AiHistoryImagesLinkData(
    id: id ?? this.id,
    historyId: historyId ?? this.historyId,
    imageId: imageId ?? this.imageId,
    createdAt: createdAt ?? this.createdAt,
  );
  AiHistoryImagesLinkData copyWithCompanion(AiHistoryImagesLinkCompanion data) {
    return AiHistoryImagesLinkData(
      id: data.id.present ? data.id.value : this.id,
      historyId: data.historyId.present ? data.historyId.value : this.historyId,
      imageId: data.imageId.present ? data.imageId.value : this.imageId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiHistoryImagesLinkData(')
          ..write('id: $id, ')
          ..write('historyId: $historyId, ')
          ..write('imageId: $imageId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, historyId, imageId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiHistoryImagesLinkData &&
          other.id == this.id &&
          other.historyId == this.historyId &&
          other.imageId == this.imageId &&
          other.createdAt == this.createdAt);
}

class AiHistoryImagesLinkCompanion
    extends UpdateCompanion<AiHistoryImagesLinkData> {
  final Value<int> id;
  final Value<int> historyId;
  final Value<int> imageId;
  final Value<DateTime> createdAt;
  const AiHistoryImagesLinkCompanion({
    this.id = const Value.absent(),
    this.historyId = const Value.absent(),
    this.imageId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AiHistoryImagesLinkCompanion.insert({
    this.id = const Value.absent(),
    required int historyId,
    required int imageId,
    this.createdAt = const Value.absent(),
  }) : historyId = Value(historyId),
       imageId = Value(imageId);
  static Insertable<AiHistoryImagesLinkData> custom({
    Expression<int>? id,
    Expression<int>? historyId,
    Expression<int>? imageId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (historyId != null) 'history_id': historyId,
      if (imageId != null) 'image_id': imageId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AiHistoryImagesLinkCompanion copyWith({
    Value<int>? id,
    Value<int>? historyId,
    Value<int>? imageId,
    Value<DateTime>? createdAt,
  }) {
    return AiHistoryImagesLinkCompanion(
      id: id ?? this.id,
      historyId: historyId ?? this.historyId,
      imageId: imageId ?? this.imageId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (historyId.present) {
      map['history_id'] = Variable<int>(historyId.value);
    }
    if (imageId.present) {
      map['image_id'] = Variable<int>(imageId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiHistoryImagesLinkCompanion(')
          ..write('id: $id, ')
          ..write('historyId: $historyId, ')
          ..write('imageId: $imageId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Subject?, String> subject =
      GeneratedColumn<String>(
        'subject',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<Subject?>($TagsTable.$convertersubjectn);
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
    'tag',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, subject, tag, color, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tag')) {
      context.handle(
        _tagMeta,
        tag.isAcceptableOrUnknown(data['tag']!, _tagMeta),
      );
    } else if (isInserting) {
      context.missing(_tagMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      subject: $TagsTable.$convertersubjectn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}subject'],
        ),
      ),
      tag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Subject, String, String> $convertersubject =
      SubjectConverter;
  static JsonTypeConverter2<Subject?, String?, String?> $convertersubjectn =
      JsonTypeConverter2.asNullable($convertersubject);
}

class Tag extends DataClass implements Insertable<Tag> {
  final int id;
  final Subject? subject;
  final String tag;
  final int? color;
  final String? description;
  const Tag({
    required this.id,
    this.subject,
    required this.tag,
    this.color,
    this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || subject != null) {
      map['subject'] = Variable<String>(
        $TagsTable.$convertersubjectn.toSql(subject),
      );
    }
    map['tag'] = Variable<String>(tag);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<int>(color);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      subject: subject == null && nullToAbsent
          ? const Value.absent()
          : Value(subject),
      tag: Value(tag),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory Tag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<int>(json['id']),
      subject: $TagsTable.$convertersubjectn.fromJson(
        serializer.fromJson<String?>(json['subject']),
      ),
      tag: serializer.fromJson<String>(json['tag']),
      color: serializer.fromJson<int?>(json['color']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'subject': serializer.toJson<String?>(
        $TagsTable.$convertersubjectn.toJson(subject),
      ),
      'tag': serializer.toJson<String>(tag),
      'color': serializer.toJson<int?>(color),
      'description': serializer.toJson<String?>(description),
    };
  }

  Tag copyWith({
    int? id,
    Value<Subject?> subject = const Value.absent(),
    String? tag,
    Value<int?> color = const Value.absent(),
    Value<String?> description = const Value.absent(),
  }) => Tag(
    id: id ?? this.id,
    subject: subject.present ? subject.value : this.subject,
    tag: tag ?? this.tag,
    color: color.present ? color.value : this.color,
    description: description.present ? description.value : this.description,
  );
  Tag copyWithCompanion(TagsCompanion data) {
    return Tag(
      id: data.id.present ? data.id.value : this.id,
      subject: data.subject.present ? data.subject.value : this.subject,
      tag: data.tag.present ? data.tag.value : this.tag,
      color: data.color.present ? data.color.value : this.color,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('subject: $subject, ')
          ..write('tag: $tag, ')
          ..write('color: $color, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, subject, tag, color, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.subject == this.subject &&
          other.tag == this.tag &&
          other.color == this.color &&
          other.description == this.description);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<int> id;
  final Value<Subject?> subject;
  final Value<String> tag;
  final Value<int?> color;
  final Value<String?> description;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.subject = const Value.absent(),
    this.tag = const Value.absent(),
    this.color = const Value.absent(),
    this.description = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    this.subject = const Value.absent(),
    required String tag,
    this.color = const Value.absent(),
    this.description = const Value.absent(),
  }) : tag = Value(tag);
  static Insertable<Tag> custom({
    Expression<int>? id,
    Expression<String>? subject,
    Expression<String>? tag,
    Expression<int>? color,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subject != null) 'subject': subject,
      if (tag != null) 'tag': tag,
      if (color != null) 'color': color,
      if (description != null) 'description': description,
    });
  }

  TagsCompanion copyWith({
    Value<int>? id,
    Value<Subject?>? subject,
    Value<String>? tag,
    Value<int?>? color,
    Value<String?>? description,
  }) {
    return TagsCompanion(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      tag: tag ?? this.tag,
      color: color ?? this.color,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(
        $TagsTable.$convertersubjectn.toSql(subject.value),
      );
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('subject: $subject, ')
          ..write('tag: $tag, ')
          ..write('color: $color, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $WordsTable extends Words with TableInfo<$WordsTable, Word> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
    'word',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _definitionPreviewMeta = const VerificationMeta(
    'definitionPreview',
  );
  @override
  late final GeneratedColumn<String> definitionPreview =
      GeneratedColumn<String>(
        'definition_preview',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _definitionMeta = const VerificationMeta(
    'definition',
  );
  @override
  late final GeneratedColumn<String> definition = GeneratedColumn<String>(
    'definition',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    word,
    definitionPreview,
    definition,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'words';
  @override
  VerificationContext validateIntegrity(
    Insertable<Word> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word')) {
      context.handle(
        _wordMeta,
        word.isAcceptableOrUnknown(data['word']!, _wordMeta),
      );
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('definition_preview')) {
      context.handle(
        _definitionPreviewMeta,
        definitionPreview.isAcceptableOrUnknown(
          data['definition_preview']!,
          _definitionPreviewMeta,
        ),
      );
    }
    if (data.containsKey('definition')) {
      context.handle(
        _definitionMeta,
        definition.isAcceptableOrUnknown(data['definition']!, _definitionMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Word map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Word(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      word: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}word'],
      )!,
      definitionPreview: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}definition_preview'],
      ),
      definition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}definition'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $WordsTable createAlias(String alias) {
    return $WordsTable(attachedDatabase, alias);
  }
}

class Word extends DataClass implements Insertable<Word> {
  final int id;
  final String word;
  final String? definitionPreview;
  final String? definition;
  final DateTime createdAt;
  const Word({
    required this.id,
    required this.word,
    this.definitionPreview,
    this.definition,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word'] = Variable<String>(word);
    if (!nullToAbsent || definitionPreview != null) {
      map['definition_preview'] = Variable<String>(definitionPreview);
    }
    if (!nullToAbsent || definition != null) {
      map['definition'] = Variable<String>(definition);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WordsCompanion toCompanion(bool nullToAbsent) {
    return WordsCompanion(
      id: Value(id),
      word: Value(word),
      definitionPreview: definitionPreview == null && nullToAbsent
          ? const Value.absent()
          : Value(definitionPreview),
      definition: definition == null && nullToAbsent
          ? const Value.absent()
          : Value(definition),
      createdAt: Value(createdAt),
    );
  }

  factory Word.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Word(
      id: serializer.fromJson<int>(json['id']),
      word: serializer.fromJson<String>(json['word']),
      definitionPreview: serializer.fromJson<String?>(
        json['definitionPreview'],
      ),
      definition: serializer.fromJson<String?>(json['definition']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'word': serializer.toJson<String>(word),
      'definitionPreview': serializer.toJson<String?>(definitionPreview),
      'definition': serializer.toJson<String?>(definition),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Word copyWith({
    int? id,
    String? word,
    Value<String?> definitionPreview = const Value.absent(),
    Value<String?> definition = const Value.absent(),
    DateTime? createdAt,
  }) => Word(
    id: id ?? this.id,
    word: word ?? this.word,
    definitionPreview: definitionPreview.present
        ? definitionPreview.value
        : this.definitionPreview,
    definition: definition.present ? definition.value : this.definition,
    createdAt: createdAt ?? this.createdAt,
  );
  Word copyWithCompanion(WordsCompanion data) {
    return Word(
      id: data.id.present ? data.id.value : this.id,
      word: data.word.present ? data.word.value : this.word,
      definitionPreview: data.definitionPreview.present
          ? data.definitionPreview.value
          : this.definitionPreview,
      definition: data.definition.present
          ? data.definition.value
          : this.definition,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Word(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('definitionPreview: $definitionPreview, ')
          ..write('definition: $definition, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, word, definitionPreview, definition, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Word &&
          other.id == this.id &&
          other.word == this.word &&
          other.definitionPreview == this.definitionPreview &&
          other.definition == this.definition &&
          other.createdAt == this.createdAt);
}

class WordsCompanion extends UpdateCompanion<Word> {
  final Value<int> id;
  final Value<String> word;
  final Value<String?> definitionPreview;
  final Value<String?> definition;
  final Value<DateTime> createdAt;
  const WordsCompanion({
    this.id = const Value.absent(),
    this.word = const Value.absent(),
    this.definitionPreview = const Value.absent(),
    this.definition = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  WordsCompanion.insert({
    this.id = const Value.absent(),
    required String word,
    this.definitionPreview = const Value.absent(),
    this.definition = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : word = Value(word);
  static Insertable<Word> custom({
    Expression<int>? id,
    Expression<String>? word,
    Expression<String>? definitionPreview,
    Expression<String>? definition,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (word != null) 'word': word,
      if (definitionPreview != null) 'definition_preview': definitionPreview,
      if (definition != null) 'definition': definition,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  WordsCompanion copyWith({
    Value<int>? id,
    Value<String>? word,
    Value<String?>? definitionPreview,
    Value<String?>? definition,
    Value<DateTime>? createdAt,
  }) {
    return WordsCompanion(
      id: id ?? this.id,
      word: word ?? this.word,
      definitionPreview: definitionPreview ?? this.definitionPreview,
      definition: definition ?? this.definition,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (definitionPreview.present) {
      map['definition_preview'] = Variable<String>(definitionPreview.value);
    }
    if (definition.present) {
      map['definition'] = Variable<String>(definition.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordsCompanion(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('definitionPreview: $definitionPreview, ')
          ..write('definition: $definition, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $WordLogsTable extends WordLogs with TableInfo<$WordLogsTable, WordLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _wordIDMeta = const VerificationMeta('wordID');
  @override
  late final GeneratedColumn<int> wordID = GeneratedColumn<int>(
    'word_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES words (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<EnglishLogType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<EnglishLogType>($WordLogsTable.$convertertype);
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, wordID, type, timestamp, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word_i_d')) {
      context.handle(
        _wordIDMeta,
        wordID.isAcceptableOrUnknown(data['word_i_d']!, _wordIDMeta),
      );
    } else if (isInserting) {
      context.missing(_wordIDMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WordLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      wordID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}word_i_d'],
      )!,
      type: $WordLogsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $WordLogsTable createAlias(String alias) {
    return $WordLogsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<EnglishLogType, String, String> $convertertype =
      EnumNameConverter(EnglishLogType.values);
}

class WordLog extends DataClass implements Insertable<WordLog> {
  final int id;
  final int wordID;
  final EnglishLogType type;
  final DateTime timestamp;
  final String? notes;
  const WordLog({
    required this.id,
    required this.wordID,
    required this.type,
    required this.timestamp,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word_i_d'] = Variable<int>(wordID);
    {
      map['type'] = Variable<String>($WordLogsTable.$convertertype.toSql(type));
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  WordLogsCompanion toCompanion(bool nullToAbsent) {
    return WordLogsCompanion(
      id: Value(id),
      wordID: Value(wordID),
      type: Value(type),
      timestamp: Value(timestamp),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory WordLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordLog(
      id: serializer.fromJson<int>(json['id']),
      wordID: serializer.fromJson<int>(json['wordID']),
      type: $WordLogsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wordID': serializer.toJson<int>(wordID),
      'type': serializer.toJson<String>(
        $WordLogsTable.$convertertype.toJson(type),
      ),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  WordLog copyWith({
    int? id,
    int? wordID,
    EnglishLogType? type,
    DateTime? timestamp,
    Value<String?> notes = const Value.absent(),
  }) => WordLog(
    id: id ?? this.id,
    wordID: wordID ?? this.wordID,
    type: type ?? this.type,
    timestamp: timestamp ?? this.timestamp,
    notes: notes.present ? notes.value : this.notes,
  );
  WordLog copyWithCompanion(WordLogsCompanion data) {
    return WordLog(
      id: data.id.present ? data.id.value : this.id,
      wordID: data.wordID.present ? data.wordID.value : this.wordID,
      type: data.type.present ? data.type.value : this.type,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordLog(')
          ..write('id: $id, ')
          ..write('wordID: $wordID, ')
          ..write('type: $type, ')
          ..write('timestamp: $timestamp, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, wordID, type, timestamp, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordLog &&
          other.id == this.id &&
          other.wordID == this.wordID &&
          other.type == this.type &&
          other.timestamp == this.timestamp &&
          other.notes == this.notes);
}

class WordLogsCompanion extends UpdateCompanion<WordLog> {
  final Value<int> id;
  final Value<int> wordID;
  final Value<EnglishLogType> type;
  final Value<DateTime> timestamp;
  final Value<String?> notes;
  const WordLogsCompanion({
    this.id = const Value.absent(),
    this.wordID = const Value.absent(),
    this.type = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.notes = const Value.absent(),
  });
  WordLogsCompanion.insert({
    this.id = const Value.absent(),
    required int wordID,
    required EnglishLogType type,
    this.timestamp = const Value.absent(),
    this.notes = const Value.absent(),
  }) : wordID = Value(wordID),
       type = Value(type);
  static Insertable<WordLog> custom({
    Expression<int>? id,
    Expression<int>? wordID,
    Expression<String>? type,
    Expression<DateTime>? timestamp,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wordID != null) 'word_i_d': wordID,
      if (type != null) 'type': type,
      if (timestamp != null) 'timestamp': timestamp,
      if (notes != null) 'notes': notes,
    });
  }

  WordLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? wordID,
    Value<EnglishLogType>? type,
    Value<DateTime>? timestamp,
    Value<String?>? notes,
  }) {
    return WordLogsCompanion(
      id: id ?? this.id,
      wordID: wordID ?? this.wordID,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wordID.present) {
      map['word_i_d'] = Variable<int>(wordID.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $WordLogsTable.$convertertype.toSql(type.value),
      );
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordLogsCompanion(')
          ..write('id: $id, ')
          ..write('wordID: $wordID, ')
          ..write('type: $type, ')
          ..write('timestamp: $timestamp, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $WordTagLinkTable extends WordTagLink
    with TableInfo<$WordTagLinkTable, WordTagLinkData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordTagLinkTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _wordIDMeta = const VerificationMeta('wordID');
  @override
  late final GeneratedColumn<int> wordID = GeneratedColumn<int>(
    'word_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES words (id)',
    ),
  );
  static const VerificationMeta _tagIDMeta = const VerificationMeta('tagID');
  @override
  late final GeneratedColumn<int> tagID = GeneratedColumn<int>(
    'tag_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [wordID, tagID];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_tag_link';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordTagLinkData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('word_i_d')) {
      context.handle(
        _wordIDMeta,
        wordID.isAcceptableOrUnknown(data['word_i_d']!, _wordIDMeta),
      );
    } else if (isInserting) {
      context.missing(_wordIDMeta);
    }
    if (data.containsKey('tag_i_d')) {
      context.handle(
        _tagIDMeta,
        tagID.isAcceptableOrUnknown(data['tag_i_d']!, _tagIDMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIDMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {wordID, tagID};
  @override
  WordTagLinkData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordTagLinkData(
      wordID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}word_i_d'],
      )!,
      tagID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tag_i_d'],
      )!,
    );
  }

  @override
  $WordTagLinkTable createAlias(String alias) {
    return $WordTagLinkTable(attachedDatabase, alias);
  }
}

class WordTagLinkData extends DataClass implements Insertable<WordTagLinkData> {
  final int wordID;
  final int tagID;
  const WordTagLinkData({required this.wordID, required this.tagID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['word_i_d'] = Variable<int>(wordID);
    map['tag_i_d'] = Variable<int>(tagID);
    return map;
  }

  WordTagLinkCompanion toCompanion(bool nullToAbsent) {
    return WordTagLinkCompanion(wordID: Value(wordID), tagID: Value(tagID));
  }

  factory WordTagLinkData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordTagLinkData(
      wordID: serializer.fromJson<int>(json['wordID']),
      tagID: serializer.fromJson<int>(json['tagID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'wordID': serializer.toJson<int>(wordID),
      'tagID': serializer.toJson<int>(tagID),
    };
  }

  WordTagLinkData copyWith({int? wordID, int? tagID}) => WordTagLinkData(
    wordID: wordID ?? this.wordID,
    tagID: tagID ?? this.tagID,
  );
  WordTagLinkData copyWithCompanion(WordTagLinkCompanion data) {
    return WordTagLinkData(
      wordID: data.wordID.present ? data.wordID.value : this.wordID,
      tagID: data.tagID.present ? data.tagID.value : this.tagID,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordTagLinkData(')
          ..write('wordID: $wordID, ')
          ..write('tagID: $tagID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(wordID, tagID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordTagLinkData &&
          other.wordID == this.wordID &&
          other.tagID == this.tagID);
}

class WordTagLinkCompanion extends UpdateCompanion<WordTagLinkData> {
  final Value<int> wordID;
  final Value<int> tagID;
  final Value<int> rowid;
  const WordTagLinkCompanion({
    this.wordID = const Value.absent(),
    this.tagID = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WordTagLinkCompanion.insert({
    required int wordID,
    required int tagID,
    this.rowid = const Value.absent(),
  }) : wordID = Value(wordID),
       tagID = Value(tagID);
  static Insertable<WordTagLinkData> custom({
    Expression<int>? wordID,
    Expression<int>? tagID,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (wordID != null) 'word_i_d': wordID,
      if (tagID != null) 'tag_i_d': tagID,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WordTagLinkCompanion copyWith({
    Value<int>? wordID,
    Value<int>? tagID,
    Value<int>? rowid,
  }) {
    return WordTagLinkCompanion(
      wordID: wordID ?? this.wordID,
      tagID: tagID ?? this.tagID,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (wordID.present) {
      map['word_i_d'] = Variable<int>(wordID.value);
    }
    if (tagID.present) {
      map['tag_i_d'] = Variable<int>(tagID.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordTagLinkCompanion(')
          ..write('wordID: $wordID, ')
          ..write('tagID: $tagID, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhrasesTable extends Phrases with TableInfo<$PhrasesTable, Phrase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhrasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _wordIDMeta = const VerificationMeta('wordID');
  @override
  late final GeneratedColumn<int> wordID = GeneratedColumn<int>(
    'word_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES words (id)',
    ),
  );
  static const VerificationMeta _phraseMeta = const VerificationMeta('phrase');
  @override
  late final GeneratedColumn<String> phrase = GeneratedColumn<String>(
    'phrase',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _definitionMeta = const VerificationMeta(
    'definition',
  );
  @override
  late final GeneratedColumn<String> definition = GeneratedColumn<String>(
    'definition',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    wordID,
    phrase,
    definition,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'phrases';
  @override
  VerificationContext validateIntegrity(
    Insertable<Phrase> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word_i_d')) {
      context.handle(
        _wordIDMeta,
        wordID.isAcceptableOrUnknown(data['word_i_d']!, _wordIDMeta),
      );
    } else if (isInserting) {
      context.missing(_wordIDMeta);
    }
    if (data.containsKey('phrase')) {
      context.handle(
        _phraseMeta,
        phrase.isAcceptableOrUnknown(data['phrase']!, _phraseMeta),
      );
    } else if (isInserting) {
      context.missing(_phraseMeta);
    }
    if (data.containsKey('definition')) {
      context.handle(
        _definitionMeta,
        definition.isAcceptableOrUnknown(data['definition']!, _definitionMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Phrase map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Phrase(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      wordID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}word_i_d'],
      )!,
      phrase: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phrase'],
      )!,
      definition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}definition'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PhrasesTable createAlias(String alias) {
    return $PhrasesTable(attachedDatabase, alias);
  }
}

class Phrase extends DataClass implements Insertable<Phrase> {
  final int id;
  final int wordID;
  final String phrase;
  final String? definition;
  final DateTime createdAt;
  const Phrase({
    required this.id,
    required this.wordID,
    required this.phrase,
    this.definition,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word_i_d'] = Variable<int>(wordID);
    map['phrase'] = Variable<String>(phrase);
    if (!nullToAbsent || definition != null) {
      map['definition'] = Variable<String>(definition);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PhrasesCompanion toCompanion(bool nullToAbsent) {
    return PhrasesCompanion(
      id: Value(id),
      wordID: Value(wordID),
      phrase: Value(phrase),
      definition: definition == null && nullToAbsent
          ? const Value.absent()
          : Value(definition),
      createdAt: Value(createdAt),
    );
  }

  factory Phrase.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Phrase(
      id: serializer.fromJson<int>(json['id']),
      wordID: serializer.fromJson<int>(json['wordID']),
      phrase: serializer.fromJson<String>(json['phrase']),
      definition: serializer.fromJson<String?>(json['definition']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wordID': serializer.toJson<int>(wordID),
      'phrase': serializer.toJson<String>(phrase),
      'definition': serializer.toJson<String?>(definition),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Phrase copyWith({
    int? id,
    int? wordID,
    String? phrase,
    Value<String?> definition = const Value.absent(),
    DateTime? createdAt,
  }) => Phrase(
    id: id ?? this.id,
    wordID: wordID ?? this.wordID,
    phrase: phrase ?? this.phrase,
    definition: definition.present ? definition.value : this.definition,
    createdAt: createdAt ?? this.createdAt,
  );
  Phrase copyWithCompanion(PhrasesCompanion data) {
    return Phrase(
      id: data.id.present ? data.id.value : this.id,
      wordID: data.wordID.present ? data.wordID.value : this.wordID,
      phrase: data.phrase.present ? data.phrase.value : this.phrase,
      definition: data.definition.present
          ? data.definition.value
          : this.definition,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Phrase(')
          ..write('id: $id, ')
          ..write('wordID: $wordID, ')
          ..write('phrase: $phrase, ')
          ..write('definition: $definition, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, wordID, phrase, definition, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Phrase &&
          other.id == this.id &&
          other.wordID == this.wordID &&
          other.phrase == this.phrase &&
          other.definition == this.definition &&
          other.createdAt == this.createdAt);
}

class PhrasesCompanion extends UpdateCompanion<Phrase> {
  final Value<int> id;
  final Value<int> wordID;
  final Value<String> phrase;
  final Value<String?> definition;
  final Value<DateTime> createdAt;
  const PhrasesCompanion({
    this.id = const Value.absent(),
    this.wordID = const Value.absent(),
    this.phrase = const Value.absent(),
    this.definition = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PhrasesCompanion.insert({
    this.id = const Value.absent(),
    required int wordID,
    required String phrase,
    this.definition = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : wordID = Value(wordID),
       phrase = Value(phrase);
  static Insertable<Phrase> custom({
    Expression<int>? id,
    Expression<int>? wordID,
    Expression<String>? phrase,
    Expression<String>? definition,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wordID != null) 'word_i_d': wordID,
      if (phrase != null) 'phrase': phrase,
      if (definition != null) 'definition': definition,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PhrasesCompanion copyWith({
    Value<int>? id,
    Value<int>? wordID,
    Value<String>? phrase,
    Value<String?>? definition,
    Value<DateTime>? createdAt,
  }) {
    return PhrasesCompanion(
      id: id ?? this.id,
      wordID: wordID ?? this.wordID,
      phrase: phrase ?? this.phrase,
      definition: definition ?? this.definition,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wordID.present) {
      map['word_i_d'] = Variable<int>(wordID.value);
    }
    if (phrase.present) {
      map['phrase'] = Variable<String>(phrase.value);
    }
    if (definition.present) {
      map['definition'] = Variable<String>(definition.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhrasesCompanion(')
          ..write('id: $id, ')
          ..write('wordID: $wordID, ')
          ..write('phrase: $phrase, ')
          ..write('definition: $definition, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PhrasesTagLinkTable extends PhrasesTagLink
    with TableInfo<$PhrasesTagLinkTable, PhrasesTagLinkData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhrasesTagLinkTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _phraseIDMeta = const VerificationMeta(
    'phraseID',
  );
  @override
  late final GeneratedColumn<int> phraseID = GeneratedColumn<int>(
    'phrase_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES phrases (id)',
    ),
  );
  static const VerificationMeta _tagIDMeta = const VerificationMeta('tagID');
  @override
  late final GeneratedColumn<int> tagID = GeneratedColumn<int>(
    'tag_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [phraseID, tagID];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'phrases_tag_link';
  @override
  VerificationContext validateIntegrity(
    Insertable<PhrasesTagLinkData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('phrase_i_d')) {
      context.handle(
        _phraseIDMeta,
        phraseID.isAcceptableOrUnknown(data['phrase_i_d']!, _phraseIDMeta),
      );
    } else if (isInserting) {
      context.missing(_phraseIDMeta);
    }
    if (data.containsKey('tag_i_d')) {
      context.handle(
        _tagIDMeta,
        tagID.isAcceptableOrUnknown(data['tag_i_d']!, _tagIDMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIDMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {phraseID, tagID};
  @override
  PhrasesTagLinkData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhrasesTagLinkData(
      phraseID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}phrase_i_d'],
      )!,
      tagID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tag_i_d'],
      )!,
    );
  }

  @override
  $PhrasesTagLinkTable createAlias(String alias) {
    return $PhrasesTagLinkTable(attachedDatabase, alias);
  }
}

class PhrasesTagLinkData extends DataClass
    implements Insertable<PhrasesTagLinkData> {
  final int phraseID;
  final int tagID;
  const PhrasesTagLinkData({required this.phraseID, required this.tagID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['phrase_i_d'] = Variable<int>(phraseID);
    map['tag_i_d'] = Variable<int>(tagID);
    return map;
  }

  PhrasesTagLinkCompanion toCompanion(bool nullToAbsent) {
    return PhrasesTagLinkCompanion(
      phraseID: Value(phraseID),
      tagID: Value(tagID),
    );
  }

  factory PhrasesTagLinkData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhrasesTagLinkData(
      phraseID: serializer.fromJson<int>(json['phraseID']),
      tagID: serializer.fromJson<int>(json['tagID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'phraseID': serializer.toJson<int>(phraseID),
      'tagID': serializer.toJson<int>(tagID),
    };
  }

  PhrasesTagLinkData copyWith({int? phraseID, int? tagID}) =>
      PhrasesTagLinkData(
        phraseID: phraseID ?? this.phraseID,
        tagID: tagID ?? this.tagID,
      );
  PhrasesTagLinkData copyWithCompanion(PhrasesTagLinkCompanion data) {
    return PhrasesTagLinkData(
      phraseID: data.phraseID.present ? data.phraseID.value : this.phraseID,
      tagID: data.tagID.present ? data.tagID.value : this.tagID,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhrasesTagLinkData(')
          ..write('phraseID: $phraseID, ')
          ..write('tagID: $tagID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(phraseID, tagID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhrasesTagLinkData &&
          other.phraseID == this.phraseID &&
          other.tagID == this.tagID);
}

class PhrasesTagLinkCompanion extends UpdateCompanion<PhrasesTagLinkData> {
  final Value<int> phraseID;
  final Value<int> tagID;
  final Value<int> rowid;
  const PhrasesTagLinkCompanion({
    this.phraseID = const Value.absent(),
    this.tagID = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhrasesTagLinkCompanion.insert({
    required int phraseID,
    required int tagID,
    this.rowid = const Value.absent(),
  }) : phraseID = Value(phraseID),
       tagID = Value(tagID);
  static Insertable<PhrasesTagLinkData> custom({
    Expression<int>? phraseID,
    Expression<int>? tagID,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (phraseID != null) 'phrase_i_d': phraseID,
      if (tagID != null) 'tag_i_d': tagID,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhrasesTagLinkCompanion copyWith({
    Value<int>? phraseID,
    Value<int>? tagID,
    Value<int>? rowid,
  }) {
    return PhrasesTagLinkCompanion(
      phraseID: phraseID ?? this.phraseID,
      tagID: tagID ?? this.tagID,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (phraseID.present) {
      map['phrase_i_d'] = Variable<int>(phraseID.value);
    }
    if (tagID.present) {
      map['tag_i_d'] = Variable<int>(tagID.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhrasesTagLinkCompanion(')
          ..write('phraseID: $phraseID, ')
          ..write('tagID: $tagID, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhraseLogsTable extends PhraseLogs
    with TableInfo<$PhraseLogsTable, PhraseLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhraseLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _phraseIDMeta = const VerificationMeta(
    'phraseID',
  );
  @override
  late final GeneratedColumn<int> phraseID = GeneratedColumn<int>(
    'phrase_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES phrases (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<EnglishLogType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<EnglishLogType>($PhraseLogsTable.$convertertype);
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, phraseID, type, timestamp, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'phrase_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<PhraseLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('phrase_i_d')) {
      context.handle(
        _phraseIDMeta,
        phraseID.isAcceptableOrUnknown(data['phrase_i_d']!, _phraseIDMeta),
      );
    } else if (isInserting) {
      context.missing(_phraseIDMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PhraseLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhraseLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      phraseID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}phrase_i_d'],
      )!,
      type: $PhraseLogsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $PhraseLogsTable createAlias(String alias) {
    return $PhraseLogsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<EnglishLogType, String, String> $convertertype =
      EnumNameConverter(EnglishLogType.values);
}

class PhraseLog extends DataClass implements Insertable<PhraseLog> {
  final int id;
  final int phraseID;
  final EnglishLogType type;
  final DateTime timestamp;
  final String? notes;
  const PhraseLog({
    required this.id,
    required this.phraseID,
    required this.type,
    required this.timestamp,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['phrase_i_d'] = Variable<int>(phraseID);
    {
      map['type'] = Variable<String>(
        $PhraseLogsTable.$convertertype.toSql(type),
      );
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PhraseLogsCompanion toCompanion(bool nullToAbsent) {
    return PhraseLogsCompanion(
      id: Value(id),
      phraseID: Value(phraseID),
      type: Value(type),
      timestamp: Value(timestamp),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory PhraseLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhraseLog(
      id: serializer.fromJson<int>(json['id']),
      phraseID: serializer.fromJson<int>(json['phraseID']),
      type: $PhraseLogsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'phraseID': serializer.toJson<int>(phraseID),
      'type': serializer.toJson<String>(
        $PhraseLogsTable.$convertertype.toJson(type),
      ),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  PhraseLog copyWith({
    int? id,
    int? phraseID,
    EnglishLogType? type,
    DateTime? timestamp,
    Value<String?> notes = const Value.absent(),
  }) => PhraseLog(
    id: id ?? this.id,
    phraseID: phraseID ?? this.phraseID,
    type: type ?? this.type,
    timestamp: timestamp ?? this.timestamp,
    notes: notes.present ? notes.value : this.notes,
  );
  PhraseLog copyWithCompanion(PhraseLogsCompanion data) {
    return PhraseLog(
      id: data.id.present ? data.id.value : this.id,
      phraseID: data.phraseID.present ? data.phraseID.value : this.phraseID,
      type: data.type.present ? data.type.value : this.type,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhraseLog(')
          ..write('id: $id, ')
          ..write('phraseID: $phraseID, ')
          ..write('type: $type, ')
          ..write('timestamp: $timestamp, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, phraseID, type, timestamp, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhraseLog &&
          other.id == this.id &&
          other.phraseID == this.phraseID &&
          other.type == this.type &&
          other.timestamp == this.timestamp &&
          other.notes == this.notes);
}

class PhraseLogsCompanion extends UpdateCompanion<PhraseLog> {
  final Value<int> id;
  final Value<int> phraseID;
  final Value<EnglishLogType> type;
  final Value<DateTime> timestamp;
  final Value<String?> notes;
  const PhraseLogsCompanion({
    this.id = const Value.absent(),
    this.phraseID = const Value.absent(),
    this.type = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.notes = const Value.absent(),
  });
  PhraseLogsCompanion.insert({
    this.id = const Value.absent(),
    required int phraseID,
    required EnglishLogType type,
    this.timestamp = const Value.absent(),
    this.notes = const Value.absent(),
  }) : phraseID = Value(phraseID),
       type = Value(type);
  static Insertable<PhraseLog> custom({
    Expression<int>? id,
    Expression<int>? phraseID,
    Expression<String>? type,
    Expression<DateTime>? timestamp,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (phraseID != null) 'phrase_i_d': phraseID,
      if (type != null) 'type': type,
      if (timestamp != null) 'timestamp': timestamp,
      if (notes != null) 'notes': notes,
    });
  }

  PhraseLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? phraseID,
    Value<EnglishLogType>? type,
    Value<DateTime>? timestamp,
    Value<String?>? notes,
  }) {
    return PhraseLogsCompanion(
      id: id ?? this.id,
      phraseID: phraseID ?? this.phraseID,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (phraseID.present) {
      map['phrase_i_d'] = Variable<int>(phraseID.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $PhraseLogsTable.$convertertype.toSql(type.value),
      );
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhraseLogsCompanion(')
          ..write('id: $id, ')
          ..write('phraseID: $phraseID, ')
          ..write('type: $type, ')
          ..write('timestamp: $timestamp, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $KnowledgeTable extends Knowledge
    with TableInfo<$KnowledgeTable, KnowledgeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KnowledgeTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Subject, String> subject =
      GeneratedColumn<String>(
        'subject',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Subject>($KnowledgeTable.$convertersubject);
  static const VerificationMeta _headMeta = const VerificationMeta('head');
  @override
  late final GeneratedColumn<String> head = GeneratedColumn<String>(
    'head',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, subject, head, body, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'knowledge';
  @override
  VerificationContext validateIntegrity(
    Insertable<KnowledgeData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('head')) {
      context.handle(
        _headMeta,
        head.isAcceptableOrUnknown(data['head']!, _headMeta),
      );
    } else if (isInserting) {
      context.missing(_headMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KnowledgeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KnowledgeData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      subject: $KnowledgeTable.$convertersubject.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}subject'],
        )!,
      ),
      head: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}head'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $KnowledgeTable createAlias(String alias) {
    return $KnowledgeTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Subject, String, String> $convertersubject =
      SubjectConverter;
}

class KnowledgeData extends DataClass implements Insertable<KnowledgeData> {
  final int id;
  final Subject subject;
  final String head;
  final String body;
  final DateTime createdAt;
  const KnowledgeData({
    required this.id,
    required this.subject,
    required this.head,
    required this.body,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['subject'] = Variable<String>(
        $KnowledgeTable.$convertersubject.toSql(subject),
      );
    }
    map['head'] = Variable<String>(head);
    map['body'] = Variable<String>(body);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  KnowledgeCompanion toCompanion(bool nullToAbsent) {
    return KnowledgeCompanion(
      id: Value(id),
      subject: Value(subject),
      head: Value(head),
      body: Value(body),
      createdAt: Value(createdAt),
    );
  }

  factory KnowledgeData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KnowledgeData(
      id: serializer.fromJson<int>(json['id']),
      subject: $KnowledgeTable.$convertersubject.fromJson(
        serializer.fromJson<String>(json['subject']),
      ),
      head: serializer.fromJson<String>(json['head']),
      body: serializer.fromJson<String>(json['body']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'subject': serializer.toJson<String>(
        $KnowledgeTable.$convertersubject.toJson(subject),
      ),
      'head': serializer.toJson<String>(head),
      'body': serializer.toJson<String>(body),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  KnowledgeData copyWith({
    int? id,
    Subject? subject,
    String? head,
    String? body,
    DateTime? createdAt,
  }) => KnowledgeData(
    id: id ?? this.id,
    subject: subject ?? this.subject,
    head: head ?? this.head,
    body: body ?? this.body,
    createdAt: createdAt ?? this.createdAt,
  );
  KnowledgeData copyWithCompanion(KnowledgeCompanion data) {
    return KnowledgeData(
      id: data.id.present ? data.id.value : this.id,
      subject: data.subject.present ? data.subject.value : this.subject,
      head: data.head.present ? data.head.value : this.head,
      body: data.body.present ? data.body.value : this.body,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeData(')
          ..write('id: $id, ')
          ..write('subject: $subject, ')
          ..write('head: $head, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, subject, head, body, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KnowledgeData &&
          other.id == this.id &&
          other.subject == this.subject &&
          other.head == this.head &&
          other.body == this.body &&
          other.createdAt == this.createdAt);
}

class KnowledgeCompanion extends UpdateCompanion<KnowledgeData> {
  final Value<int> id;
  final Value<Subject> subject;
  final Value<String> head;
  final Value<String> body;
  final Value<DateTime> createdAt;
  const KnowledgeCompanion({
    this.id = const Value.absent(),
    this.subject = const Value.absent(),
    this.head = const Value.absent(),
    this.body = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  KnowledgeCompanion.insert({
    this.id = const Value.absent(),
    required Subject subject,
    required String head,
    required String body,
    this.createdAt = const Value.absent(),
  }) : subject = Value(subject),
       head = Value(head),
       body = Value(body);
  static Insertable<KnowledgeData> custom({
    Expression<int>? id,
    Expression<String>? subject,
    Expression<String>? head,
    Expression<String>? body,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subject != null) 'subject': subject,
      if (head != null) 'head': head,
      if (body != null) 'body': body,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  KnowledgeCompanion copyWith({
    Value<int>? id,
    Value<Subject>? subject,
    Value<String>? head,
    Value<String>? body,
    Value<DateTime>? createdAt,
  }) {
    return KnowledgeCompanion(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      head: head ?? this.head,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(
        $KnowledgeTable.$convertersubject.toSql(subject.value),
      );
    }
    if (head.present) {
      map['head'] = Variable<String>(head.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeCompanion(')
          ..write('id: $id, ')
          ..write('subject: $subject, ')
          ..write('head: $head, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $KnowledgeLogsTable extends KnowledgeLogs
    with TableInfo<$KnowledgeLogsTable, KnowledgeLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KnowledgeLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _knowledgeIDMeta = const VerificationMeta(
    'knowledgeID',
  );
  @override
  late final GeneratedColumn<int> knowledgeID = GeneratedColumn<int>(
    'knowledge_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES knowledge (id)',
    ),
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
    'time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  late final GeneratedColumnWithTypeConverter<KnowledgeLogType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<KnowledgeLogType>($KnowledgeLogsTable.$convertertype);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, knowledgeID, time, type, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'knowledge_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<KnowledgeLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('knowledge_i_d')) {
      context.handle(
        _knowledgeIDMeta,
        knowledgeID.isAcceptableOrUnknown(
          data['knowledge_i_d']!,
          _knowledgeIDMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_knowledgeIDMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KnowledgeLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KnowledgeLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      knowledgeID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}knowledge_i_d'],
      )!,
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}time'],
      )!,
      type: $KnowledgeLogsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $KnowledgeLogsTable createAlias(String alias) {
    return $KnowledgeLogsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<KnowledgeLogType, String, String> $convertertype =
      EnumNameConverter(KnowledgeLogType.values);
}

class KnowledgeLog extends DataClass implements Insertable<KnowledgeLog> {
  final int id;
  final int knowledgeID;
  final DateTime time;
  final KnowledgeLogType type;
  final String? notes;
  const KnowledgeLog({
    required this.id,
    required this.knowledgeID,
    required this.time,
    required this.type,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['knowledge_i_d'] = Variable<int>(knowledgeID);
    map['time'] = Variable<DateTime>(time);
    {
      map['type'] = Variable<String>(
        $KnowledgeLogsTable.$convertertype.toSql(type),
      );
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  KnowledgeLogsCompanion toCompanion(bool nullToAbsent) {
    return KnowledgeLogsCompanion(
      id: Value(id),
      knowledgeID: Value(knowledgeID),
      time: Value(time),
      type: Value(type),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory KnowledgeLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KnowledgeLog(
      id: serializer.fromJson<int>(json['id']),
      knowledgeID: serializer.fromJson<int>(json['knowledgeID']),
      time: serializer.fromJson<DateTime>(json['time']),
      type: $KnowledgeLogsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'knowledgeID': serializer.toJson<int>(knowledgeID),
      'time': serializer.toJson<DateTime>(time),
      'type': serializer.toJson<String>(
        $KnowledgeLogsTable.$convertertype.toJson(type),
      ),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  KnowledgeLog copyWith({
    int? id,
    int? knowledgeID,
    DateTime? time,
    KnowledgeLogType? type,
    Value<String?> notes = const Value.absent(),
  }) => KnowledgeLog(
    id: id ?? this.id,
    knowledgeID: knowledgeID ?? this.knowledgeID,
    time: time ?? this.time,
    type: type ?? this.type,
    notes: notes.present ? notes.value : this.notes,
  );
  KnowledgeLog copyWithCompanion(KnowledgeLogsCompanion data) {
    return KnowledgeLog(
      id: data.id.present ? data.id.value : this.id,
      knowledgeID: data.knowledgeID.present
          ? data.knowledgeID.value
          : this.knowledgeID,
      time: data.time.present ? data.time.value : this.time,
      type: data.type.present ? data.type.value : this.type,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeLog(')
          ..write('id: $id, ')
          ..write('knowledgeID: $knowledgeID, ')
          ..write('time: $time, ')
          ..write('type: $type, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, knowledgeID, time, type, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KnowledgeLog &&
          other.id == this.id &&
          other.knowledgeID == this.knowledgeID &&
          other.time == this.time &&
          other.type == this.type &&
          other.notes == this.notes);
}

class KnowledgeLogsCompanion extends UpdateCompanion<KnowledgeLog> {
  final Value<int> id;
  final Value<int> knowledgeID;
  final Value<DateTime> time;
  final Value<KnowledgeLogType> type;
  final Value<String?> notes;
  const KnowledgeLogsCompanion({
    this.id = const Value.absent(),
    this.knowledgeID = const Value.absent(),
    this.time = const Value.absent(),
    this.type = const Value.absent(),
    this.notes = const Value.absent(),
  });
  KnowledgeLogsCompanion.insert({
    this.id = const Value.absent(),
    required int knowledgeID,
    this.time = const Value.absent(),
    required KnowledgeLogType type,
    this.notes = const Value.absent(),
  }) : knowledgeID = Value(knowledgeID),
       type = Value(type);
  static Insertable<KnowledgeLog> custom({
    Expression<int>? id,
    Expression<int>? knowledgeID,
    Expression<DateTime>? time,
    Expression<String>? type,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (knowledgeID != null) 'knowledge_i_d': knowledgeID,
      if (time != null) 'time': time,
      if (type != null) 'type': type,
      if (notes != null) 'notes': notes,
    });
  }

  KnowledgeLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? knowledgeID,
    Value<DateTime>? time,
    Value<KnowledgeLogType>? type,
    Value<String?>? notes,
  }) {
    return KnowledgeLogsCompanion(
      id: id ?? this.id,
      knowledgeID: knowledgeID ?? this.knowledgeID,
      time: time ?? this.time,
      type: type ?? this.type,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (knowledgeID.present) {
      map['knowledge_i_d'] = Variable<int>(knowledgeID.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $KnowledgeLogsTable.$convertertype.toSql(type.value),
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeLogsCompanion(')
          ..write('id: $id, ')
          ..write('knowledgeID: $knowledgeID, ')
          ..write('time: $time, ')
          ..write('type: $type, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $KnowledgeTagLinkTable extends KnowledgeTagLink
    with TableInfo<$KnowledgeTagLinkTable, KnowledgeTagLinkData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KnowledgeTagLinkTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _knowledgeIDMeta = const VerificationMeta(
    'knowledgeID',
  );
  @override
  late final GeneratedColumn<int> knowledgeID = GeneratedColumn<int>(
    'knowledge_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES knowledge (id)',
    ),
  );
  static const VerificationMeta _tagIDMeta = const VerificationMeta('tagID');
  @override
  late final GeneratedColumn<int> tagID = GeneratedColumn<int>(
    'tag_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [knowledgeID, tagID];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'knowledge_tag_link';
  @override
  VerificationContext validateIntegrity(
    Insertable<KnowledgeTagLinkData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('knowledge_i_d')) {
      context.handle(
        _knowledgeIDMeta,
        knowledgeID.isAcceptableOrUnknown(
          data['knowledge_i_d']!,
          _knowledgeIDMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_knowledgeIDMeta);
    }
    if (data.containsKey('tag_i_d')) {
      context.handle(
        _tagIDMeta,
        tagID.isAcceptableOrUnknown(data['tag_i_d']!, _tagIDMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIDMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {knowledgeID, tagID};
  @override
  KnowledgeTagLinkData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KnowledgeTagLinkData(
      knowledgeID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}knowledge_i_d'],
      )!,
      tagID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tag_i_d'],
      )!,
    );
  }

  @override
  $KnowledgeTagLinkTable createAlias(String alias) {
    return $KnowledgeTagLinkTable(attachedDatabase, alias);
  }
}

class KnowledgeTagLinkData extends DataClass
    implements Insertable<KnowledgeTagLinkData> {
  final int knowledgeID;
  final int tagID;
  const KnowledgeTagLinkData({required this.knowledgeID, required this.tagID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['knowledge_i_d'] = Variable<int>(knowledgeID);
    map['tag_i_d'] = Variable<int>(tagID);
    return map;
  }

  KnowledgeTagLinkCompanion toCompanion(bool nullToAbsent) {
    return KnowledgeTagLinkCompanion(
      knowledgeID: Value(knowledgeID),
      tagID: Value(tagID),
    );
  }

  factory KnowledgeTagLinkData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KnowledgeTagLinkData(
      knowledgeID: serializer.fromJson<int>(json['knowledgeID']),
      tagID: serializer.fromJson<int>(json['tagID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'knowledgeID': serializer.toJson<int>(knowledgeID),
      'tagID': serializer.toJson<int>(tagID),
    };
  }

  KnowledgeTagLinkData copyWith({int? knowledgeID, int? tagID}) =>
      KnowledgeTagLinkData(
        knowledgeID: knowledgeID ?? this.knowledgeID,
        tagID: tagID ?? this.tagID,
      );
  KnowledgeTagLinkData copyWithCompanion(KnowledgeTagLinkCompanion data) {
    return KnowledgeTagLinkData(
      knowledgeID: data.knowledgeID.present
          ? data.knowledgeID.value
          : this.knowledgeID,
      tagID: data.tagID.present ? data.tagID.value : this.tagID,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeTagLinkData(')
          ..write('knowledgeID: $knowledgeID, ')
          ..write('tagID: $tagID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(knowledgeID, tagID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KnowledgeTagLinkData &&
          other.knowledgeID == this.knowledgeID &&
          other.tagID == this.tagID);
}

class KnowledgeTagLinkCompanion extends UpdateCompanion<KnowledgeTagLinkData> {
  final Value<int> knowledgeID;
  final Value<int> tagID;
  final Value<int> rowid;
  const KnowledgeTagLinkCompanion({
    this.knowledgeID = const Value.absent(),
    this.tagID = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KnowledgeTagLinkCompanion.insert({
    required int knowledgeID,
    required int tagID,
    this.rowid = const Value.absent(),
  }) : knowledgeID = Value(knowledgeID),
       tagID = Value(tagID);
  static Insertable<KnowledgeTagLinkData> custom({
    Expression<int>? knowledgeID,
    Expression<int>? tagID,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (knowledgeID != null) 'knowledge_i_d': knowledgeID,
      if (tagID != null) 'tag_i_d': tagID,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KnowledgeTagLinkCompanion copyWith({
    Value<int>? knowledgeID,
    Value<int>? tagID,
    Value<int>? rowid,
  }) {
    return KnowledgeTagLinkCompanion(
      knowledgeID: knowledgeID ?? this.knowledgeID,
      tagID: tagID ?? this.tagID,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (knowledgeID.present) {
      map['knowledge_i_d'] = Variable<int>(knowledgeID.value);
    }
    if (tagID.present) {
      map['tag_i_d'] = Variable<int>(tagID.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeTagLinkCompanion(')
          ..write('knowledgeID: $knowledgeID, ')
          ..write('tagID: $tagID, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionsTable extends Questions
    with TableInfo<$QuestionsTable, Question> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Subject, String> subject =
      GeneratedColumn<String>(
        'subject',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Subject>($QuestionsTable.$convertersubject);
  static const VerificationMeta _questionHeaderMeta = const VerificationMeta(
    'questionHeader',
  );
  @override
  late final GeneratedColumn<String> questionHeader = GeneratedColumn<String>(
    'question_header',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionBodyMeta = const VerificationMeta(
    'questionBody',
  );
  @override
  late final GeneratedColumn<String> questionBody = GeneratedColumn<String>(
    'question_body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subject,
    questionHeader,
    questionBody,
    source,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'questions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Question> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('question_header')) {
      context.handle(
        _questionHeaderMeta,
        questionHeader.isAcceptableOrUnknown(
          data['question_header']!,
          _questionHeaderMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionHeaderMeta);
    }
    if (data.containsKey('question_body')) {
      context.handle(
        _questionBodyMeta,
        questionBody.isAcceptableOrUnknown(
          data['question_body']!,
          _questionBodyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionBodyMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Question map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Question(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      subject: $QuestionsTable.$convertersubject.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}subject'],
        )!,
      ),
      questionHeader: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_header'],
      )!,
      questionBody: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_body'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $QuestionsTable createAlias(String alias) {
    return $QuestionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Subject, String, String> $convertersubject =
      SubjectConverter;
}

class Question extends DataClass implements Insertable<Question> {
  final int id;
  final Subject subject;
  final String questionHeader;
  final String questionBody;
  final String? source;
  final DateTime createdAt;
  const Question({
    required this.id,
    required this.subject,
    required this.questionHeader,
    required this.questionBody,
    this.source,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['subject'] = Variable<String>(
        $QuestionsTable.$convertersubject.toSql(subject),
      );
    }
    map['question_header'] = Variable<String>(questionHeader);
    map['question_body'] = Variable<String>(questionBody);
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  QuestionsCompanion toCompanion(bool nullToAbsent) {
    return QuestionsCompanion(
      id: Value(id),
      subject: Value(subject),
      questionHeader: Value(questionHeader),
      questionBody: Value(questionBody),
      source: source == null && nullToAbsent
          ? const Value.absent()
          : Value(source),
      createdAt: Value(createdAt),
    );
  }

  factory Question.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Question(
      id: serializer.fromJson<int>(json['id']),
      subject: $QuestionsTable.$convertersubject.fromJson(
        serializer.fromJson<String>(json['subject']),
      ),
      questionHeader: serializer.fromJson<String>(json['questionHeader']),
      questionBody: serializer.fromJson<String>(json['questionBody']),
      source: serializer.fromJson<String?>(json['source']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'subject': serializer.toJson<String>(
        $QuestionsTable.$convertersubject.toJson(subject),
      ),
      'questionHeader': serializer.toJson<String>(questionHeader),
      'questionBody': serializer.toJson<String>(questionBody),
      'source': serializer.toJson<String?>(source),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Question copyWith({
    int? id,
    Subject? subject,
    String? questionHeader,
    String? questionBody,
    Value<String?> source = const Value.absent(),
    DateTime? createdAt,
  }) => Question(
    id: id ?? this.id,
    subject: subject ?? this.subject,
    questionHeader: questionHeader ?? this.questionHeader,
    questionBody: questionBody ?? this.questionBody,
    source: source.present ? source.value : this.source,
    createdAt: createdAt ?? this.createdAt,
  );
  Question copyWithCompanion(QuestionsCompanion data) {
    return Question(
      id: data.id.present ? data.id.value : this.id,
      subject: data.subject.present ? data.subject.value : this.subject,
      questionHeader: data.questionHeader.present
          ? data.questionHeader.value
          : this.questionHeader,
      questionBody: data.questionBody.present
          ? data.questionBody.value
          : this.questionBody,
      source: data.source.present ? data.source.value : this.source,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Question(')
          ..write('id: $id, ')
          ..write('subject: $subject, ')
          ..write('questionHeader: $questionHeader, ')
          ..write('questionBody: $questionBody, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, subject, questionHeader, questionBody, source, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Question &&
          other.id == this.id &&
          other.subject == this.subject &&
          other.questionHeader == this.questionHeader &&
          other.questionBody == this.questionBody &&
          other.source == this.source &&
          other.createdAt == this.createdAt);
}

class QuestionsCompanion extends UpdateCompanion<Question> {
  final Value<int> id;
  final Value<Subject> subject;
  final Value<String> questionHeader;
  final Value<String> questionBody;
  final Value<String?> source;
  final Value<DateTime> createdAt;
  const QuestionsCompanion({
    this.id = const Value.absent(),
    this.subject = const Value.absent(),
    this.questionHeader = const Value.absent(),
    this.questionBody = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  QuestionsCompanion.insert({
    this.id = const Value.absent(),
    required Subject subject,
    required String questionHeader,
    required String questionBody,
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : subject = Value(subject),
       questionHeader = Value(questionHeader),
       questionBody = Value(questionBody);
  static Insertable<Question> custom({
    Expression<int>? id,
    Expression<String>? subject,
    Expression<String>? questionHeader,
    Expression<String>? questionBody,
    Expression<String>? source,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subject != null) 'subject': subject,
      if (questionHeader != null) 'question_header': questionHeader,
      if (questionBody != null) 'question_body': questionBody,
      if (source != null) 'source': source,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  QuestionsCompanion copyWith({
    Value<int>? id,
    Value<Subject>? subject,
    Value<String>? questionHeader,
    Value<String>? questionBody,
    Value<String?>? source,
    Value<DateTime>? createdAt,
  }) {
    return QuestionsCompanion(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      questionHeader: questionHeader ?? this.questionHeader,
      questionBody: questionBody ?? this.questionBody,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(
        $QuestionsTable.$convertersubject.toSql(subject.value),
      );
    }
    if (questionHeader.present) {
      map['question_header'] = Variable<String>(questionHeader.value);
    }
    if (questionBody.present) {
      map['question_body'] = Variable<String>(questionBody.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionsCompanion(')
          ..write('id: $id, ')
          ..write('subject: $subject, ')
          ..write('questionHeader: $questionHeader, ')
          ..write('questionBody: $questionBody, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $QuestionsTagLinkTable extends QuestionsTagLink
    with TableInfo<$QuestionsTagLinkTable, QuestionsTagLinkData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionsTagLinkTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _questionIDMeta = const VerificationMeta(
    'questionID',
  );
  @override
  late final GeneratedColumn<int> questionID = GeneratedColumn<int>(
    'question_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES questions (id)',
    ),
  );
  static const VerificationMeta _tagIDMeta = const VerificationMeta('tagID');
  @override
  late final GeneratedColumn<int> tagID = GeneratedColumn<int>(
    'tag_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [questionID, tagID];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'questions_tag_link';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuestionsTagLinkData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('question_i_d')) {
      context.handle(
        _questionIDMeta,
        questionID.isAcceptableOrUnknown(
          data['question_i_d']!,
          _questionIDMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionIDMeta);
    }
    if (data.containsKey('tag_i_d')) {
      context.handle(
        _tagIDMeta,
        tagID.isAcceptableOrUnknown(data['tag_i_d']!, _tagIDMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIDMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {questionID, tagID};
  @override
  QuestionsTagLinkData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionsTagLinkData(
      questionID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}question_i_d'],
      )!,
      tagID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tag_i_d'],
      )!,
    );
  }

  @override
  $QuestionsTagLinkTable createAlias(String alias) {
    return $QuestionsTagLinkTable(attachedDatabase, alias);
  }
}

class QuestionsTagLinkData extends DataClass
    implements Insertable<QuestionsTagLinkData> {
  final int questionID;
  final int tagID;
  const QuestionsTagLinkData({required this.questionID, required this.tagID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['question_i_d'] = Variable<int>(questionID);
    map['tag_i_d'] = Variable<int>(tagID);
    return map;
  }

  QuestionsTagLinkCompanion toCompanion(bool nullToAbsent) {
    return QuestionsTagLinkCompanion(
      questionID: Value(questionID),
      tagID: Value(tagID),
    );
  }

  factory QuestionsTagLinkData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionsTagLinkData(
      questionID: serializer.fromJson<int>(json['questionID']),
      tagID: serializer.fromJson<int>(json['tagID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'questionID': serializer.toJson<int>(questionID),
      'tagID': serializer.toJson<int>(tagID),
    };
  }

  QuestionsTagLinkData copyWith({int? questionID, int? tagID}) =>
      QuestionsTagLinkData(
        questionID: questionID ?? this.questionID,
        tagID: tagID ?? this.tagID,
      );
  QuestionsTagLinkData copyWithCompanion(QuestionsTagLinkCompanion data) {
    return QuestionsTagLinkData(
      questionID: data.questionID.present
          ? data.questionID.value
          : this.questionID,
      tagID: data.tagID.present ? data.tagID.value : this.tagID,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionsTagLinkData(')
          ..write('questionID: $questionID, ')
          ..write('tagID: $tagID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(questionID, tagID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionsTagLinkData &&
          other.questionID == this.questionID &&
          other.tagID == this.tagID);
}

class QuestionsTagLinkCompanion extends UpdateCompanion<QuestionsTagLinkData> {
  final Value<int> questionID;
  final Value<int> tagID;
  final Value<int> rowid;
  const QuestionsTagLinkCompanion({
    this.questionID = const Value.absent(),
    this.tagID = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionsTagLinkCompanion.insert({
    required int questionID,
    required int tagID,
    this.rowid = const Value.absent(),
  }) : questionID = Value(questionID),
       tagID = Value(tagID);
  static Insertable<QuestionsTagLinkData> custom({
    Expression<int>? questionID,
    Expression<int>? tagID,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (questionID != null) 'question_i_d': questionID,
      if (tagID != null) 'tag_i_d': tagID,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionsTagLinkCompanion copyWith({
    Value<int>? questionID,
    Value<int>? tagID,
    Value<int>? rowid,
  }) {
    return QuestionsTagLinkCompanion(
      questionID: questionID ?? this.questionID,
      tagID: tagID ?? this.tagID,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (questionID.present) {
      map['question_i_d'] = Variable<int>(questionID.value);
    }
    if (tagID.present) {
      map['tag_i_d'] = Variable<int>(tagID.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionsTagLinkCompanion(')
          ..write('questionID: $questionID, ')
          ..write('tagID: $tagID, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionLogsTable extends QuestionLogs
    with TableInfo<$QuestionLogsTable, QuestionLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _questionIDMeta = const VerificationMeta(
    'questionID',
  );
  @override
  late final GeneratedColumn<int> questionID = GeneratedColumn<int>(
    'question_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES questions (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<QuestionLogType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<QuestionLogType>($QuestionLogsTable.$convertertype);
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    questionID,
    type,
    timestamp,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuestionLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('question_i_d')) {
      context.handle(
        _questionIDMeta,
        questionID.isAcceptableOrUnknown(
          data['question_i_d']!,
          _questionIDMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionIDMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuestionLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      questionID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}question_i_d'],
      )!,
      type: $QuestionLogsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $QuestionLogsTable createAlias(String alias) {
    return $QuestionLogsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<QuestionLogType, String, String> $convertertype =
      const EnumNameConverter(QuestionLogType.values);
}

class QuestionLog extends DataClass implements Insertable<QuestionLog> {
  final int id;
  final int questionID;
  final QuestionLogType type;
  final DateTime timestamp;
  final String? notes;
  const QuestionLog({
    required this.id,
    required this.questionID,
    required this.type,
    required this.timestamp,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['question_i_d'] = Variable<int>(questionID);
    {
      map['type'] = Variable<String>(
        $QuestionLogsTable.$convertertype.toSql(type),
      );
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  QuestionLogsCompanion toCompanion(bool nullToAbsent) {
    return QuestionLogsCompanion(
      id: Value(id),
      questionID: Value(questionID),
      type: Value(type),
      timestamp: Value(timestamp),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory QuestionLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionLog(
      id: serializer.fromJson<int>(json['id']),
      questionID: serializer.fromJson<int>(json['questionID']),
      type: $QuestionLogsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'questionID': serializer.toJson<int>(questionID),
      'type': serializer.toJson<String>(
        $QuestionLogsTable.$convertertype.toJson(type),
      ),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  QuestionLog copyWith({
    int? id,
    int? questionID,
    QuestionLogType? type,
    DateTime? timestamp,
    Value<String?> notes = const Value.absent(),
  }) => QuestionLog(
    id: id ?? this.id,
    questionID: questionID ?? this.questionID,
    type: type ?? this.type,
    timestamp: timestamp ?? this.timestamp,
    notes: notes.present ? notes.value : this.notes,
  );
  QuestionLog copyWithCompanion(QuestionLogsCompanion data) {
    return QuestionLog(
      id: data.id.present ? data.id.value : this.id,
      questionID: data.questionID.present
          ? data.questionID.value
          : this.questionID,
      type: data.type.present ? data.type.value : this.type,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionLog(')
          ..write('id: $id, ')
          ..write('questionID: $questionID, ')
          ..write('type: $type, ')
          ..write('timestamp: $timestamp, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, questionID, type, timestamp, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionLog &&
          other.id == this.id &&
          other.questionID == this.questionID &&
          other.type == this.type &&
          other.timestamp == this.timestamp &&
          other.notes == this.notes);
}

class QuestionLogsCompanion extends UpdateCompanion<QuestionLog> {
  final Value<int> id;
  final Value<int> questionID;
  final Value<QuestionLogType> type;
  final Value<DateTime> timestamp;
  final Value<String?> notes;
  const QuestionLogsCompanion({
    this.id = const Value.absent(),
    this.questionID = const Value.absent(),
    this.type = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.notes = const Value.absent(),
  });
  QuestionLogsCompanion.insert({
    this.id = const Value.absent(),
    required int questionID,
    required QuestionLogType type,
    this.timestamp = const Value.absent(),
    this.notes = const Value.absent(),
  }) : questionID = Value(questionID),
       type = Value(type);
  static Insertable<QuestionLog> custom({
    Expression<int>? id,
    Expression<int>? questionID,
    Expression<String>? type,
    Expression<DateTime>? timestamp,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questionID != null) 'question_i_d': questionID,
      if (type != null) 'type': type,
      if (timestamp != null) 'timestamp': timestamp,
      if (notes != null) 'notes': notes,
    });
  }

  QuestionLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? questionID,
    Value<QuestionLogType>? type,
    Value<DateTime>? timestamp,
    Value<String?>? notes,
  }) {
    return QuestionLogsCompanion(
      id: id ?? this.id,
      questionID: questionID ?? this.questionID,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (questionID.present) {
      map['question_i_d'] = Variable<int>(questionID.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $QuestionLogsTable.$convertertype.toSql(type.value),
      );
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionLogsCompanion(')
          ..write('id: $id, ')
          ..write('questionID: $questionID, ')
          ..write('type: $type, ')
          ..write('timestamp: $timestamp, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $QuestionPicsLinkTable extends QuestionPicsLink
    with TableInfo<$QuestionPicsLinkTable, QuestionPicsLinkData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionPicsLinkTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<int> questionId = GeneratedColumn<int>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES questions (id)',
    ),
  );
  static const VerificationMeta _picIdMeta = const VerificationMeta('picId');
  @override
  late final GeneratedColumn<int> picId = GeneratedColumn<int>(
    'pic_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES images (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [questionId, picId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_pics_link';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuestionPicsLinkData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('pic_id')) {
      context.handle(
        _picIdMeta,
        picId.isAcceptableOrUnknown(data['pic_id']!, _picIdMeta),
      );
    } else if (isInserting) {
      context.missing(_picIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {questionId, picId};
  @override
  QuestionPicsLinkData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionPicsLinkData(
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}question_id'],
      )!,
      picId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pic_id'],
      )!,
    );
  }

  @override
  $QuestionPicsLinkTable createAlias(String alias) {
    return $QuestionPicsLinkTable(attachedDatabase, alias);
  }
}

class QuestionPicsLinkData extends DataClass
    implements Insertable<QuestionPicsLinkData> {
  final int questionId;
  final int picId;
  const QuestionPicsLinkData({required this.questionId, required this.picId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['question_id'] = Variable<int>(questionId);
    map['pic_id'] = Variable<int>(picId);
    return map;
  }

  QuestionPicsLinkCompanion toCompanion(bool nullToAbsent) {
    return QuestionPicsLinkCompanion(
      questionId: Value(questionId),
      picId: Value(picId),
    );
  }

  factory QuestionPicsLinkData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionPicsLinkData(
      questionId: serializer.fromJson<int>(json['questionId']),
      picId: serializer.fromJson<int>(json['picId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'questionId': serializer.toJson<int>(questionId),
      'picId': serializer.toJson<int>(picId),
    };
  }

  QuestionPicsLinkData copyWith({int? questionId, int? picId}) =>
      QuestionPicsLinkData(
        questionId: questionId ?? this.questionId,
        picId: picId ?? this.picId,
      );
  QuestionPicsLinkData copyWithCompanion(QuestionPicsLinkCompanion data) {
    return QuestionPicsLinkData(
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      picId: data.picId.present ? data.picId.value : this.picId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionPicsLinkData(')
          ..write('questionId: $questionId, ')
          ..write('picId: $picId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(questionId, picId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionPicsLinkData &&
          other.questionId == this.questionId &&
          other.picId == this.picId);
}

class QuestionPicsLinkCompanion extends UpdateCompanion<QuestionPicsLinkData> {
  final Value<int> questionId;
  final Value<int> picId;
  final Value<int> rowid;
  const QuestionPicsLinkCompanion({
    this.questionId = const Value.absent(),
    this.picId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionPicsLinkCompanion.insert({
    required int questionId,
    required int picId,
    this.rowid = const Value.absent(),
  }) : questionId = Value(questionId),
       picId = Value(picId);
  static Insertable<QuestionPicsLinkData> custom({
    Expression<int>? questionId,
    Expression<int>? picId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (questionId != null) 'question_id': questionId,
      if (picId != null) 'pic_id': picId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionPicsLinkCompanion copyWith({
    Value<int>? questionId,
    Value<int>? picId,
    Value<int>? rowid,
  }) {
    return QuestionPicsLinkCompanion(
      questionId: questionId ?? this.questionId,
      picId: picId ?? this.picId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (questionId.present) {
      map['question_id'] = Variable<int>(questionId.value);
    }
    if (picId.present) {
      map['pic_id'] = Variable<int>(picId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionPicsLinkCompanion(')
          ..write('questionId: $questionId, ')
          ..write('picId: $picId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AnswersTable extends Answers with TableInfo<$AnswersTable, Answer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnswersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<int> questionId = GeneratedColumn<int>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES questions (id)',
    ),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _headMeta = const VerificationMeta('head');
  @override
  late final GeneratedColumn<String> head = GeneratedColumn<String>(
    'head',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _answerMeta = const VerificationMeta('answer');
  @override
  late final GeneratedColumn<String> answer = GeneratedColumn<String>(
    'answer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    questionId,
    note,
    head,
    source,
    answer,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'answers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Answer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('head')) {
      context.handle(
        _headMeta,
        head.isAcceptableOrUnknown(data['head']!, _headMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('answer')) {
      context.handle(
        _answerMeta,
        answer.isAcceptableOrUnknown(data['answer']!, _answerMeta),
      );
    } else if (isInserting) {
      context.missing(_answerMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Answer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Answer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}question_id'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      head: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}head'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      ),
      answer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answer'],
      )!,
    );
  }

  @override
  $AnswersTable createAlias(String alias) {
    return $AnswersTable(attachedDatabase, alias);
  }
}

class Answer extends DataClass implements Insertable<Answer> {
  final int id;
  final int questionId;
  final String? note;
  final String? head;
  final String? source;
  final String answer;
  const Answer({
    required this.id,
    required this.questionId,
    this.note,
    this.head,
    this.source,
    required this.answer,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['question_id'] = Variable<int>(questionId);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || head != null) {
      map['head'] = Variable<String>(head);
    }
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    map['answer'] = Variable<String>(answer);
    return map;
  }

  AnswersCompanion toCompanion(bool nullToAbsent) {
    return AnswersCompanion(
      id: Value(id),
      questionId: Value(questionId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      head: head == null && nullToAbsent ? const Value.absent() : Value(head),
      source: source == null && nullToAbsent
          ? const Value.absent()
          : Value(source),
      answer: Value(answer),
    );
  }

  factory Answer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Answer(
      id: serializer.fromJson<int>(json['id']),
      questionId: serializer.fromJson<int>(json['questionId']),
      note: serializer.fromJson<String?>(json['note']),
      head: serializer.fromJson<String?>(json['head']),
      source: serializer.fromJson<String?>(json['source']),
      answer: serializer.fromJson<String>(json['answer']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'questionId': serializer.toJson<int>(questionId),
      'note': serializer.toJson<String?>(note),
      'head': serializer.toJson<String?>(head),
      'source': serializer.toJson<String?>(source),
      'answer': serializer.toJson<String>(answer),
    };
  }

  Answer copyWith({
    int? id,
    int? questionId,
    Value<String?> note = const Value.absent(),
    Value<String?> head = const Value.absent(),
    Value<String?> source = const Value.absent(),
    String? answer,
  }) => Answer(
    id: id ?? this.id,
    questionId: questionId ?? this.questionId,
    note: note.present ? note.value : this.note,
    head: head.present ? head.value : this.head,
    source: source.present ? source.value : this.source,
    answer: answer ?? this.answer,
  );
  Answer copyWithCompanion(AnswersCompanion data) {
    return Answer(
      id: data.id.present ? data.id.value : this.id,
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      note: data.note.present ? data.note.value : this.note,
      head: data.head.present ? data.head.value : this.head,
      source: data.source.present ? data.source.value : this.source,
      answer: data.answer.present ? data.answer.value : this.answer,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Answer(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('note: $note, ')
          ..write('head: $head, ')
          ..write('source: $source, ')
          ..write('answer: $answer')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, questionId, note, head, source, answer);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Answer &&
          other.id == this.id &&
          other.questionId == this.questionId &&
          other.note == this.note &&
          other.head == this.head &&
          other.source == this.source &&
          other.answer == this.answer);
}

class AnswersCompanion extends UpdateCompanion<Answer> {
  final Value<int> id;
  final Value<int> questionId;
  final Value<String?> note;
  final Value<String?> head;
  final Value<String?> source;
  final Value<String> answer;
  const AnswersCompanion({
    this.id = const Value.absent(),
    this.questionId = const Value.absent(),
    this.note = const Value.absent(),
    this.head = const Value.absent(),
    this.source = const Value.absent(),
    this.answer = const Value.absent(),
  });
  AnswersCompanion.insert({
    this.id = const Value.absent(),
    required int questionId,
    this.note = const Value.absent(),
    this.head = const Value.absent(),
    this.source = const Value.absent(),
    required String answer,
  }) : questionId = Value(questionId),
       answer = Value(answer);
  static Insertable<Answer> custom({
    Expression<int>? id,
    Expression<int>? questionId,
    Expression<String>? note,
    Expression<String>? head,
    Expression<String>? source,
    Expression<String>? answer,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questionId != null) 'question_id': questionId,
      if (note != null) 'note': note,
      if (head != null) 'head': head,
      if (source != null) 'source': source,
      if (answer != null) 'answer': answer,
    });
  }

  AnswersCompanion copyWith({
    Value<int>? id,
    Value<int>? questionId,
    Value<String?>? note,
    Value<String?>? head,
    Value<String?>? source,
    Value<String>? answer,
  }) {
    return AnswersCompanion(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      note: note ?? this.note,
      head: head ?? this.head,
      source: source ?? this.source,
      answer: answer ?? this.answer,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<int>(questionId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (head.present) {
      map['head'] = Variable<String>(head.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (answer.present) {
      map['answer'] = Variable<String>(answer.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnswersCompanion(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('note: $note, ')
          ..write('head: $head, ')
          ..write('source: $source, ')
          ..write('answer: $answer')
          ..write(')'))
        .toString();
  }
}

class $AnswersTagsLinkTable extends AnswersTagsLink
    with TableInfo<$AnswersTagsLinkTable, AnswersTagsLinkData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnswersTagsLinkTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _answerIDMeta = const VerificationMeta(
    'answerID',
  );
  @override
  late final GeneratedColumn<int> answerID = GeneratedColumn<int>(
    'answer_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES answers (id)',
    ),
  );
  static const VerificationMeta _tagIDMeta = const VerificationMeta('tagID');
  @override
  late final GeneratedColumn<int> tagID = GeneratedColumn<int>(
    'tag_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [answerID, tagID];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'answers_tags_link';
  @override
  VerificationContext validateIntegrity(
    Insertable<AnswersTagsLinkData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('answer_i_d')) {
      context.handle(
        _answerIDMeta,
        answerID.isAcceptableOrUnknown(data['answer_i_d']!, _answerIDMeta),
      );
    } else if (isInserting) {
      context.missing(_answerIDMeta);
    }
    if (data.containsKey('tag_i_d')) {
      context.handle(
        _tagIDMeta,
        tagID.isAcceptableOrUnknown(data['tag_i_d']!, _tagIDMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIDMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {answerID, tagID};
  @override
  AnswersTagsLinkData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnswersTagsLinkData(
      answerID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}answer_i_d'],
      )!,
      tagID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tag_i_d'],
      )!,
    );
  }

  @override
  $AnswersTagsLinkTable createAlias(String alias) {
    return $AnswersTagsLinkTable(attachedDatabase, alias);
  }
}

class AnswersTagsLinkData extends DataClass
    implements Insertable<AnswersTagsLinkData> {
  final int answerID;
  final int tagID;
  const AnswersTagsLinkData({required this.answerID, required this.tagID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['answer_i_d'] = Variable<int>(answerID);
    map['tag_i_d'] = Variable<int>(tagID);
    return map;
  }

  AnswersTagsLinkCompanion toCompanion(bool nullToAbsent) {
    return AnswersTagsLinkCompanion(
      answerID: Value(answerID),
      tagID: Value(tagID),
    );
  }

  factory AnswersTagsLinkData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnswersTagsLinkData(
      answerID: serializer.fromJson<int>(json['answerID']),
      tagID: serializer.fromJson<int>(json['tagID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'answerID': serializer.toJson<int>(answerID),
      'tagID': serializer.toJson<int>(tagID),
    };
  }

  AnswersTagsLinkData copyWith({int? answerID, int? tagID}) =>
      AnswersTagsLinkData(
        answerID: answerID ?? this.answerID,
        tagID: tagID ?? this.tagID,
      );
  AnswersTagsLinkData copyWithCompanion(AnswersTagsLinkCompanion data) {
    return AnswersTagsLinkData(
      answerID: data.answerID.present ? data.answerID.value : this.answerID,
      tagID: data.tagID.present ? data.tagID.value : this.tagID,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnswersTagsLinkData(')
          ..write('answerID: $answerID, ')
          ..write('tagID: $tagID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(answerID, tagID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnswersTagsLinkData &&
          other.answerID == this.answerID &&
          other.tagID == this.tagID);
}

class AnswersTagsLinkCompanion extends UpdateCompanion<AnswersTagsLinkData> {
  final Value<int> answerID;
  final Value<int> tagID;
  final Value<int> rowid;
  const AnswersTagsLinkCompanion({
    this.answerID = const Value.absent(),
    this.tagID = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AnswersTagsLinkCompanion.insert({
    required int answerID,
    required int tagID,
    this.rowid = const Value.absent(),
  }) : answerID = Value(answerID),
       tagID = Value(tagID);
  static Insertable<AnswersTagsLinkData> custom({
    Expression<int>? answerID,
    Expression<int>? tagID,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (answerID != null) 'answer_i_d': answerID,
      if (tagID != null) 'tag_i_d': tagID,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AnswersTagsLinkCompanion copyWith({
    Value<int>? answerID,
    Value<int>? tagID,
    Value<int>? rowid,
  }) {
    return AnswersTagsLinkCompanion(
      answerID: answerID ?? this.answerID,
      tagID: tagID ?? this.tagID,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (answerID.present) {
      map['answer_i_d'] = Variable<int>(answerID.value);
    }
    if (tagID.present) {
      map['tag_i_d'] = Variable<int>(tagID.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnswersTagsLinkCompanion(')
          ..write('answerID: $answerID, ')
          ..write('tagID: $tagID, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AnswerPicsLinkTable extends AnswerPicsLink
    with TableInfo<$AnswerPicsLinkTable, AnswerPicsLinkData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnswerPicsLinkTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _answerIDMeta = const VerificationMeta(
    'answerID',
  );
  @override
  late final GeneratedColumn<int> answerID = GeneratedColumn<int>(
    'answer_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES answers (id)',
    ),
  );
  static const VerificationMeta _picIDMeta = const VerificationMeta('picID');
  @override
  late final GeneratedColumn<int> picID = GeneratedColumn<int>(
    'pic_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES images (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [answerID, picID];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'answer_pics_link';
  @override
  VerificationContext validateIntegrity(
    Insertable<AnswerPicsLinkData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('answer_i_d')) {
      context.handle(
        _answerIDMeta,
        answerID.isAcceptableOrUnknown(data['answer_i_d']!, _answerIDMeta),
      );
    } else if (isInserting) {
      context.missing(_answerIDMeta);
    }
    if (data.containsKey('pic_i_d')) {
      context.handle(
        _picIDMeta,
        picID.isAcceptableOrUnknown(data['pic_i_d']!, _picIDMeta),
      );
    } else if (isInserting) {
      context.missing(_picIDMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {answerID, picID};
  @override
  AnswerPicsLinkData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnswerPicsLinkData(
      answerID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}answer_i_d'],
      )!,
      picID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pic_i_d'],
      )!,
    );
  }

  @override
  $AnswerPicsLinkTable createAlias(String alias) {
    return $AnswerPicsLinkTable(attachedDatabase, alias);
  }
}

class AnswerPicsLinkData extends DataClass
    implements Insertable<AnswerPicsLinkData> {
  final int answerID;
  final int picID;
  const AnswerPicsLinkData({required this.answerID, required this.picID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['answer_i_d'] = Variable<int>(answerID);
    map['pic_i_d'] = Variable<int>(picID);
    return map;
  }

  AnswerPicsLinkCompanion toCompanion(bool nullToAbsent) {
    return AnswerPicsLinkCompanion(
      answerID: Value(answerID),
      picID: Value(picID),
    );
  }

  factory AnswerPicsLinkData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnswerPicsLinkData(
      answerID: serializer.fromJson<int>(json['answerID']),
      picID: serializer.fromJson<int>(json['picID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'answerID': serializer.toJson<int>(answerID),
      'picID': serializer.toJson<int>(picID),
    };
  }

  AnswerPicsLinkData copyWith({int? answerID, int? picID}) =>
      AnswerPicsLinkData(
        answerID: answerID ?? this.answerID,
        picID: picID ?? this.picID,
      );
  AnswerPicsLinkData copyWithCompanion(AnswerPicsLinkCompanion data) {
    return AnswerPicsLinkData(
      answerID: data.answerID.present ? data.answerID.value : this.answerID,
      picID: data.picID.present ? data.picID.value : this.picID,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnswerPicsLinkData(')
          ..write('answerID: $answerID, ')
          ..write('picID: $picID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(answerID, picID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnswerPicsLinkData &&
          other.answerID == this.answerID &&
          other.picID == this.picID);
}

class AnswerPicsLinkCompanion extends UpdateCompanion<AnswerPicsLinkData> {
  final Value<int> answerID;
  final Value<int> picID;
  final Value<int> rowid;
  const AnswerPicsLinkCompanion({
    this.answerID = const Value.absent(),
    this.picID = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AnswerPicsLinkCompanion.insert({
    required int answerID,
    required int picID,
    this.rowid = const Value.absent(),
  }) : answerID = Value(answerID),
       picID = Value(picID);
  static Insertable<AnswerPicsLinkData> custom({
    Expression<int>? answerID,
    Expression<int>? picID,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (answerID != null) 'answer_i_d': answerID,
      if (picID != null) 'pic_i_d': picID,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AnswerPicsLinkCompanion copyWith({
    Value<int>? answerID,
    Value<int>? picID,
    Value<int>? rowid,
  }) {
    return AnswerPicsLinkCompanion(
      answerID: answerID ?? this.answerID,
      picID: picID ?? this.picID,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (answerID.present) {
      map['answer_i_d'] = Variable<int>(answerID.value);
    }
    if (picID.present) {
      map['pic_i_d'] = Variable<int>(picID.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnswerPicsLinkCompanion(')
          ..write('answerID: $answerID, ')
          ..write('picID: $picID, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionAnalysisTable extends QuestionAnalysis
    with TableInfo<$QuestionAnalysisTable, QuestionAnalysi> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionAnalysisTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES questions (id)',
    ),
  );
  static const VerificationMeta _bestAnswerMeta = const VerificationMeta(
    'bestAnswer',
  );
  @override
  late final GeneratedColumn<int> bestAnswer = GeneratedColumn<int>(
    'best_answer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES answers (id)',
    ),
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _analysisMeta = const VerificationMeta(
    'analysis',
  );
  @override
  late final GeneratedColumn<String> analysis = GeneratedColumn<String>(
    'analysis',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, bestAnswer, reason, analysis];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_analysis';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuestionAnalysi> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('best_answer')) {
      context.handle(
        _bestAnswerMeta,
        bestAnswer.isAcceptableOrUnknown(data['best_answer']!, _bestAnswerMeta),
      );
    } else if (isInserting) {
      context.missing(_bestAnswerMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('analysis')) {
      context.handle(
        _analysisMeta,
        analysis.isAcceptableOrUnknown(data['analysis']!, _analysisMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  QuestionAnalysi map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionAnalysi(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bestAnswer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}best_answer'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      ),
      analysis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}analysis'],
      ),
    );
  }

  @override
  $QuestionAnalysisTable createAlias(String alias) {
    return $QuestionAnalysisTable(attachedDatabase, alias);
  }
}

class QuestionAnalysi extends DataClass implements Insertable<QuestionAnalysi> {
  final int id;
  final int bestAnswer;

  /// 该字段为错因分析
  final String? reason;

  /// 该字段为易错点分析
  final String? analysis;
  const QuestionAnalysi({
    required this.id,
    required this.bestAnswer,
    this.reason,
    this.analysis,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['best_answer'] = Variable<int>(bestAnswer);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    if (!nullToAbsent || analysis != null) {
      map['analysis'] = Variable<String>(analysis);
    }
    return map;
  }

  QuestionAnalysisCompanion toCompanion(bool nullToAbsent) {
    return QuestionAnalysisCompanion(
      id: Value(id),
      bestAnswer: Value(bestAnswer),
      reason: reason == null && nullToAbsent
          ? const Value.absent()
          : Value(reason),
      analysis: analysis == null && nullToAbsent
          ? const Value.absent()
          : Value(analysis),
    );
  }

  factory QuestionAnalysi.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionAnalysi(
      id: serializer.fromJson<int>(json['id']),
      bestAnswer: serializer.fromJson<int>(json['bestAnswer']),
      reason: serializer.fromJson<String?>(json['reason']),
      analysis: serializer.fromJson<String?>(json['analysis']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bestAnswer': serializer.toJson<int>(bestAnswer),
      'reason': serializer.toJson<String?>(reason),
      'analysis': serializer.toJson<String?>(analysis),
    };
  }

  QuestionAnalysi copyWith({
    int? id,
    int? bestAnswer,
    Value<String?> reason = const Value.absent(),
    Value<String?> analysis = const Value.absent(),
  }) => QuestionAnalysi(
    id: id ?? this.id,
    bestAnswer: bestAnswer ?? this.bestAnswer,
    reason: reason.present ? reason.value : this.reason,
    analysis: analysis.present ? analysis.value : this.analysis,
  );
  QuestionAnalysi copyWithCompanion(QuestionAnalysisCompanion data) {
    return QuestionAnalysi(
      id: data.id.present ? data.id.value : this.id,
      bestAnswer: data.bestAnswer.present
          ? data.bestAnswer.value
          : this.bestAnswer,
      reason: data.reason.present ? data.reason.value : this.reason,
      analysis: data.analysis.present ? data.analysis.value : this.analysis,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionAnalysi(')
          ..write('id: $id, ')
          ..write('bestAnswer: $bestAnswer, ')
          ..write('reason: $reason, ')
          ..write('analysis: $analysis')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bestAnswer, reason, analysis);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionAnalysi &&
          other.id == this.id &&
          other.bestAnswer == this.bestAnswer &&
          other.reason == this.reason &&
          other.analysis == this.analysis);
}

class QuestionAnalysisCompanion extends UpdateCompanion<QuestionAnalysi> {
  final Value<int> id;
  final Value<int> bestAnswer;
  final Value<String?> reason;
  final Value<String?> analysis;
  final Value<int> rowid;
  const QuestionAnalysisCompanion({
    this.id = const Value.absent(),
    this.bestAnswer = const Value.absent(),
    this.reason = const Value.absent(),
    this.analysis = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionAnalysisCompanion.insert({
    required int id,
    required int bestAnswer,
    this.reason = const Value.absent(),
    this.analysis = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       bestAnswer = Value(bestAnswer);
  static Insertable<QuestionAnalysi> custom({
    Expression<int>? id,
    Expression<int>? bestAnswer,
    Expression<String>? reason,
    Expression<String>? analysis,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bestAnswer != null) 'best_answer': bestAnswer,
      if (reason != null) 'reason': reason,
      if (analysis != null) 'analysis': analysis,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionAnalysisCompanion copyWith({
    Value<int>? id,
    Value<int>? bestAnswer,
    Value<String?>? reason,
    Value<String?>? analysis,
    Value<int>? rowid,
  }) {
    return QuestionAnalysisCompanion(
      id: id ?? this.id,
      bestAnswer: bestAnswer ?? this.bestAnswer,
      reason: reason ?? this.reason,
      analysis: analysis ?? this.analysis,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bestAnswer.present) {
      map['best_answer'] = Variable<int>(bestAnswer.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (analysis.present) {
      map['analysis'] = Variable<String>(analysis.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionAnalysisCompanion(')
          ..write('id: $id, ')
          ..write('bestAnswer: $bestAnswer, ')
          ..write('reason: $reason, ')
          ..write('analysis: $analysis, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionKnowledgeLinkTable extends QuestionKnowledgeLink
    with TableInfo<$QuestionKnowledgeLinkTable, QuestionKnowledgeLinkData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionKnowledgeLinkTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<int> questionId = GeneratedColumn<int>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES questions (id)',
    ),
  );
  static const VerificationMeta _knowledgeIdMeta = const VerificationMeta(
    'knowledgeId',
  );
  @override
  late final GeneratedColumn<int> knowledgeId = GeneratedColumn<int>(
    'knowledge_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES knowledge (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [questionId, knowledgeId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_knowledge_link';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuestionKnowledgeLinkData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('knowledge_id')) {
      context.handle(
        _knowledgeIdMeta,
        knowledgeId.isAcceptableOrUnknown(
          data['knowledge_id']!,
          _knowledgeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_knowledgeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {questionId, knowledgeId};
  @override
  QuestionKnowledgeLinkData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionKnowledgeLinkData(
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}question_id'],
      )!,
      knowledgeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}knowledge_id'],
      )!,
    );
  }

  @override
  $QuestionKnowledgeLinkTable createAlias(String alias) {
    return $QuestionKnowledgeLinkTable(attachedDatabase, alias);
  }
}

class QuestionKnowledgeLinkData extends DataClass
    implements Insertable<QuestionKnowledgeLinkData> {
  final int questionId;
  final int knowledgeId;
  const QuestionKnowledgeLinkData({
    required this.questionId,
    required this.knowledgeId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['question_id'] = Variable<int>(questionId);
    map['knowledge_id'] = Variable<int>(knowledgeId);
    return map;
  }

  QuestionKnowledgeLinkCompanion toCompanion(bool nullToAbsent) {
    return QuestionKnowledgeLinkCompanion(
      questionId: Value(questionId),
      knowledgeId: Value(knowledgeId),
    );
  }

  factory QuestionKnowledgeLinkData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionKnowledgeLinkData(
      questionId: serializer.fromJson<int>(json['questionId']),
      knowledgeId: serializer.fromJson<int>(json['knowledgeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'questionId': serializer.toJson<int>(questionId),
      'knowledgeId': serializer.toJson<int>(knowledgeId),
    };
  }

  QuestionKnowledgeLinkData copyWith({int? questionId, int? knowledgeId}) =>
      QuestionKnowledgeLinkData(
        questionId: questionId ?? this.questionId,
        knowledgeId: knowledgeId ?? this.knowledgeId,
      );
  QuestionKnowledgeLinkData copyWithCompanion(
    QuestionKnowledgeLinkCompanion data,
  ) {
    return QuestionKnowledgeLinkData(
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      knowledgeId: data.knowledgeId.present
          ? data.knowledgeId.value
          : this.knowledgeId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionKnowledgeLinkData(')
          ..write('questionId: $questionId, ')
          ..write('knowledgeId: $knowledgeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(questionId, knowledgeId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionKnowledgeLinkData &&
          other.questionId == this.questionId &&
          other.knowledgeId == this.knowledgeId);
}

class QuestionKnowledgeLinkCompanion
    extends UpdateCompanion<QuestionKnowledgeLinkData> {
  final Value<int> questionId;
  final Value<int> knowledgeId;
  final Value<int> rowid;
  const QuestionKnowledgeLinkCompanion({
    this.questionId = const Value.absent(),
    this.knowledgeId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionKnowledgeLinkCompanion.insert({
    required int questionId,
    required int knowledgeId,
    this.rowid = const Value.absent(),
  }) : questionId = Value(questionId),
       knowledgeId = Value(knowledgeId);
  static Insertable<QuestionKnowledgeLinkData> custom({
    Expression<int>? questionId,
    Expression<int>? knowledgeId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (questionId != null) 'question_id': questionId,
      if (knowledgeId != null) 'knowledge_id': knowledgeId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionKnowledgeLinkCompanion copyWith({
    Value<int>? questionId,
    Value<int>? knowledgeId,
    Value<int>? rowid,
  }) {
    return QuestionKnowledgeLinkCompanion(
      questionId: questionId ?? this.questionId,
      knowledgeId: knowledgeId ?? this.knowledgeId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (questionId.present) {
      map['question_id'] = Variable<int>(questionId.value);
    }
    if (knowledgeId.present) {
      map['knowledge_id'] = Variable<int>(knowledgeId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionKnowledgeLinkCompanion(')
          ..write('questionId: $questionId, ')
          ..write('knowledgeId: $knowledgeId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ImagesTable images = $ImagesTable(this);
  late final $AiProvidersTable aiProviders = $AiProvidersTable(this);
  late final $SessionTable session = $SessionTable(this);
  late final $AiHistoriesTable aiHistories = $AiHistoriesTable(this);
  late final $PromptsTable prompts = $PromptsTable(this);
  late final $AiHistoryImagesLinkTable aiHistoryImagesLink =
      $AiHistoryImagesLinkTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $WordsTable words = $WordsTable(this);
  late final $WordLogsTable wordLogs = $WordLogsTable(this);
  late final $WordTagLinkTable wordTagLink = $WordTagLinkTable(this);
  late final $PhrasesTable phrases = $PhrasesTable(this);
  late final $PhrasesTagLinkTable phrasesTagLink = $PhrasesTagLinkTable(this);
  late final $PhraseLogsTable phraseLogs = $PhraseLogsTable(this);
  late final $KnowledgeTable knowledge = $KnowledgeTable(this);
  late final $KnowledgeLogsTable knowledgeLogs = $KnowledgeLogsTable(this);
  late final $KnowledgeTagLinkTable knowledgeTagLink = $KnowledgeTagLinkTable(
    this,
  );
  late final $QuestionsTable questions = $QuestionsTable(this);
  late final $QuestionsTagLinkTable questionsTagLink = $QuestionsTagLinkTable(
    this,
  );
  late final $QuestionLogsTable questionLogs = $QuestionLogsTable(this);
  late final $QuestionPicsLinkTable questionPicsLink = $QuestionPicsLinkTable(
    this,
  );
  late final $AnswersTable answers = $AnswersTable(this);
  late final $AnswersTagsLinkTable answersTagsLink = $AnswersTagsLinkTable(
    this,
  );
  late final $AnswerPicsLinkTable answerPicsLink = $AnswerPicsLinkTable(this);
  late final $QuestionAnalysisTable questionAnalysis = $QuestionAnalysisTable(
    this,
  );
  late final $QuestionKnowledgeLinkTable questionKnowledgeLink =
      $QuestionKnowledgeLinkTable(this);
  late final AiProviderDao aiProviderDao = AiProviderDao(this as AppDatabase);
  late final AiHistoryDao aiHistoryDao = AiHistoryDao(this as AppDatabase);
  late final AiHistoryImagesLinkDao aiHistoryImagesLinkDao =
      AiHistoryImagesLinkDao(this as AppDatabase);
  late final PromptDao promptDao = PromptDao(this as AppDatabase);
  late final TagsDao tagsDao = TagsDao(this as AppDatabase);
  late final WordsDao wordsDao = WordsDao(this as AppDatabase);
  late final KnowledgeDao knowledgeDao = KnowledgeDao(this as AppDatabase);
  late final QuestionsDao questionsDao = QuestionsDao(this as AppDatabase);
  late final PhrasesDao phrasesDao = PhrasesDao(this as AppDatabase);
  late final ImagesDao imagesDao = ImagesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    images,
    aiProviders,
    session,
    aiHistories,
    prompts,
    aiHistoryImagesLink,
    tags,
    words,
    wordLogs,
    wordTagLink,
    phrases,
    phrasesTagLink,
    phraseLogs,
    knowledge,
    knowledgeLogs,
    knowledgeTagLink,
    questions,
    questionsTagLink,
    questionLogs,
    questionPicsLink,
    answers,
    answersTagsLink,
    answerPicsLink,
    questionAnalysis,
    questionKnowledgeLink,
  ];
}

typedef $$ImagesTableCreateCompanionBuilder =
    ImagesCompanion Function({
      Value<int> id,
      required String name,
      Value<DateTime> createAt,
      Value<String?> desc,
      Value<String?> path,
    });
typedef $$ImagesTableUpdateCompanionBuilder =
    ImagesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<DateTime> createAt,
      Value<String?> desc,
      Value<String?> path,
    });

final class $$ImagesTableReferences
    extends BaseReferences<_$AppDatabase, $ImagesTable, Image> {
  $$ImagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AiProvidersTable, List<AiProvider>>
  _aiProvidersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.aiProviders,
    aliasName: $_aliasNameGenerator(db.images.id, db.aiProviders.iconId),
  );

  $$AiProvidersTableProcessedTableManager get aiProvidersRefs {
    final manager = $$AiProvidersTableTableManager(
      $_db,
      $_db.aiProviders,
    ).filter((f) => f.iconId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_aiProvidersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $AiHistoryImagesLinkTable,
    List<AiHistoryImagesLinkData>
  >
  _aiHistoryImagesLinkRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.aiHistoryImagesLink,
        aliasName: $_aliasNameGenerator(
          db.images.id,
          db.aiHistoryImagesLink.imageId,
        ),
      );

  $$AiHistoryImagesLinkTableProcessedTableManager get aiHistoryImagesLinkRefs {
    final manager = $$AiHistoryImagesLinkTableTableManager(
      $_db,
      $_db.aiHistoryImagesLink,
    ).filter((f) => f.imageId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _aiHistoryImagesLinkRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$QuestionPicsLinkTable, List<QuestionPicsLinkData>>
  _questionPicsLinkRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.questionPicsLink,
    aliasName: $_aliasNameGenerator(db.images.id, db.questionPicsLink.picId),
  );

  $$QuestionPicsLinkTableProcessedTableManager get questionPicsLinkRefs {
    final manager = $$QuestionPicsLinkTableTableManager(
      $_db,
      $_db.questionPicsLink,
    ).filter((f) => f.picId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _questionPicsLinkRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AnswerPicsLinkTable, List<AnswerPicsLinkData>>
  _answerPicsLinkRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.answerPicsLink,
    aliasName: $_aliasNameGenerator(db.images.id, db.answerPicsLink.picID),
  );

  $$AnswerPicsLinkTableProcessedTableManager get answerPicsLinkRefs {
    final manager = $$AnswerPicsLinkTableTableManager(
      $_db,
      $_db.answerPicsLink,
    ).filter((f) => f.picID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_answerPicsLinkRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ImagesTableFilterComposer
    extends Composer<_$AppDatabase, $ImagesTable> {
  $$ImagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get desc => $composableBuilder(
    column: $table.desc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> aiProvidersRefs(
    Expression<bool> Function($$AiProvidersTableFilterComposer f) f,
  ) {
    final $$AiProvidersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.aiProviders,
      getReferencedColumn: (t) => t.iconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiProvidersTableFilterComposer(
            $db: $db,
            $table: $db.aiProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> aiHistoryImagesLinkRefs(
    Expression<bool> Function($$AiHistoryImagesLinkTableFilterComposer f) f,
  ) {
    final $$AiHistoryImagesLinkTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.aiHistoryImagesLink,
      getReferencedColumn: (t) => t.imageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiHistoryImagesLinkTableFilterComposer(
            $db: $db,
            $table: $db.aiHistoryImagesLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> questionPicsLinkRefs(
    Expression<bool> Function($$QuestionPicsLinkTableFilterComposer f) f,
  ) {
    final $$QuestionPicsLinkTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionPicsLink,
      getReferencedColumn: (t) => t.picId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionPicsLinkTableFilterComposer(
            $db: $db,
            $table: $db.questionPicsLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> answerPicsLinkRefs(
    Expression<bool> Function($$AnswerPicsLinkTableFilterComposer f) f,
  ) {
    final $$AnswerPicsLinkTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.answerPicsLink,
      getReferencedColumn: (t) => t.picID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnswerPicsLinkTableFilterComposer(
            $db: $db,
            $table: $db.answerPicsLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ImagesTableOrderingComposer
    extends Composer<_$AppDatabase, $ImagesTable> {
  $$ImagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get desc => $composableBuilder(
    column: $table.desc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ImagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ImagesTable> {
  $$ImagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createAt =>
      $composableBuilder(column: $table.createAt, builder: (column) => column);

  GeneratedColumn<String> get desc =>
      $composableBuilder(column: $table.desc, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  Expression<T> aiProvidersRefs<T extends Object>(
    Expression<T> Function($$AiProvidersTableAnnotationComposer a) f,
  ) {
    final $$AiProvidersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.aiProviders,
      getReferencedColumn: (t) => t.iconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiProvidersTableAnnotationComposer(
            $db: $db,
            $table: $db.aiProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> aiHistoryImagesLinkRefs<T extends Object>(
    Expression<T> Function($$AiHistoryImagesLinkTableAnnotationComposer a) f,
  ) {
    final $$AiHistoryImagesLinkTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.aiHistoryImagesLink,
          getReferencedColumn: (t) => t.imageId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AiHistoryImagesLinkTableAnnotationComposer(
                $db: $db,
                $table: $db.aiHistoryImagesLink,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> questionPicsLinkRefs<T extends Object>(
    Expression<T> Function($$QuestionPicsLinkTableAnnotationComposer a) f,
  ) {
    final $$QuestionPicsLinkTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionPicsLink,
      getReferencedColumn: (t) => t.picId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionPicsLinkTableAnnotationComposer(
            $db: $db,
            $table: $db.questionPicsLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> answerPicsLinkRefs<T extends Object>(
    Expression<T> Function($$AnswerPicsLinkTableAnnotationComposer a) f,
  ) {
    final $$AnswerPicsLinkTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.answerPicsLink,
      getReferencedColumn: (t) => t.picID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnswerPicsLinkTableAnnotationComposer(
            $db: $db,
            $table: $db.answerPicsLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ImagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ImagesTable,
          Image,
          $$ImagesTableFilterComposer,
          $$ImagesTableOrderingComposer,
          $$ImagesTableAnnotationComposer,
          $$ImagesTableCreateCompanionBuilder,
          $$ImagesTableUpdateCompanionBuilder,
          (Image, $$ImagesTableReferences),
          Image,
          PrefetchHooks Function({
            bool aiProvidersRefs,
            bool aiHistoryImagesLinkRefs,
            bool questionPicsLinkRefs,
            bool answerPicsLinkRefs,
          })
        > {
  $$ImagesTableTableManager(_$AppDatabase db, $ImagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ImagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ImagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ImagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
                Value<String?> desc = const Value.absent(),
                Value<String?> path = const Value.absent(),
              }) => ImagesCompanion(
                id: id,
                name: name,
                createAt: createAt,
                desc: desc,
                path: path,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<DateTime> createAt = const Value.absent(),
                Value<String?> desc = const Value.absent(),
                Value<String?> path = const Value.absent(),
              }) => ImagesCompanion.insert(
                id: id,
                name: name,
                createAt: createAt,
                desc: desc,
                path: path,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ImagesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                aiProvidersRefs = false,
                aiHistoryImagesLinkRefs = false,
                questionPicsLinkRefs = false,
                answerPicsLinkRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (aiProvidersRefs) db.aiProviders,
                    if (aiHistoryImagesLinkRefs) db.aiHistoryImagesLink,
                    if (questionPicsLinkRefs) db.questionPicsLink,
                    if (answerPicsLinkRefs) db.answerPicsLink,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (aiProvidersRefs)
                        await $_getPrefetchedData<
                          Image,
                          $ImagesTable,
                          AiProvider
                        >(
                          currentTable: table,
                          referencedTable: $$ImagesTableReferences
                              ._aiProvidersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ImagesTableReferences(
                                db,
                                table,
                                p0,
                              ).aiProvidersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.iconId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (aiHistoryImagesLinkRefs)
                        await $_getPrefetchedData<
                          Image,
                          $ImagesTable,
                          AiHistoryImagesLinkData
                        >(
                          currentTable: table,
                          referencedTable: $$ImagesTableReferences
                              ._aiHistoryImagesLinkRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ImagesTableReferences(
                                db,
                                table,
                                p0,
                              ).aiHistoryImagesLinkRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.imageId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (questionPicsLinkRefs)
                        await $_getPrefetchedData<
                          Image,
                          $ImagesTable,
                          QuestionPicsLinkData
                        >(
                          currentTable: table,
                          referencedTable: $$ImagesTableReferences
                              ._questionPicsLinkRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ImagesTableReferences(
                                db,
                                table,
                                p0,
                              ).questionPicsLinkRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.picId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (answerPicsLinkRefs)
                        await $_getPrefetchedData<
                          Image,
                          $ImagesTable,
                          AnswerPicsLinkData
                        >(
                          currentTable: table,
                          referencedTable: $$ImagesTableReferences
                              ._answerPicsLinkRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ImagesTableReferences(
                                db,
                                table,
                                p0,
                              ).answerPicsLinkRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.picID == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ImagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ImagesTable,
      Image,
      $$ImagesTableFilterComposer,
      $$ImagesTableOrderingComposer,
      $$ImagesTableAnnotationComposer,
      $$ImagesTableCreateCompanionBuilder,
      $$ImagesTableUpdateCompanionBuilder,
      (Image, $$ImagesTableReferences),
      Image,
      PrefetchHooks Function({
        bool aiProvidersRefs,
        bool aiHistoryImagesLinkRefs,
        bool questionPicsLinkRefs,
        bool answerPicsLinkRefs,
      })
    >;
typedef $$AiProvidersTableCreateCompanionBuilder =
    AiProvidersCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      required String baseUrl,
      required String apiKey,
      Value<int?> iconId,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<String> modelsJson,
    });
typedef $$AiProvidersTableUpdateCompanionBuilder =
    AiProvidersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<String> baseUrl,
      Value<String> apiKey,
      Value<int?> iconId,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<String> modelsJson,
    });

final class $$AiProvidersTableReferences
    extends BaseReferences<_$AppDatabase, $AiProvidersTable, AiProvider> {
  $$AiProvidersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ImagesTable _iconIdTable(_$AppDatabase db) => db.images.createAlias(
    $_aliasNameGenerator(db.aiProviders.iconId, db.images.id),
  );

  $$ImagesTableProcessedTableManager? get iconId {
    final $_column = $_itemColumn<int>('icon_id');
    if ($_column == null) return null;
    final manager = $$ImagesTableTableManager(
      $_db,
      $_db.images,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_iconIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$AiHistoriesTable, List<AiHistory>>
  _aiHistoriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.aiHistories,
    aliasName: $_aliasNameGenerator(
      db.aiProviders.id,
      db.aiHistories.providerId,
    ),
  );

  $$AiHistoriesTableProcessedTableManager get aiHistoriesRefs {
    final manager = $$AiHistoriesTableTableManager(
      $_db,
      $_db.aiHistories,
    ).filter((f) => f.providerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_aiHistoriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AiProvidersTableFilterComposer
    extends Composer<_$AppDatabase, $AiProvidersTable> {
  $$AiProvidersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get apiKey => $composableBuilder(
    column: $table.apiKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelsJson => $composableBuilder(
    column: $table.modelsJson,
    builder: (column) => ColumnFilters(column),
  );

  $$ImagesTableFilterComposer get iconId {
    final $$ImagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.iconId,
      referencedTable: $db.images,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImagesTableFilterComposer(
            $db: $db,
            $table: $db.images,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> aiHistoriesRefs(
    Expression<bool> Function($$AiHistoriesTableFilterComposer f) f,
  ) {
    final $$AiHistoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.aiHistories,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiHistoriesTableFilterComposer(
            $db: $db,
            $table: $db.aiHistories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AiProvidersTableOrderingComposer
    extends Composer<_$AppDatabase, $AiProvidersTable> {
  $$AiProvidersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get apiKey => $composableBuilder(
    column: $table.apiKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelsJson => $composableBuilder(
    column: $table.modelsJson,
    builder: (column) => ColumnOrderings(column),
  );

  $$ImagesTableOrderingComposer get iconId {
    final $$ImagesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.iconId,
      referencedTable: $db.images,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImagesTableOrderingComposer(
            $db: $db,
            $table: $db.images,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AiProvidersTableAnnotationComposer
    extends Composer<_$AppDatabase, $AiProvidersTable> {
  $$AiProvidersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get baseUrl =>
      $composableBuilder(column: $table.baseUrl, builder: (column) => column);

  GeneratedColumn<String> get apiKey =>
      $composableBuilder(column: $table.apiKey, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get modelsJson => $composableBuilder(
    column: $table.modelsJson,
    builder: (column) => column,
  );

  $$ImagesTableAnnotationComposer get iconId {
    final $$ImagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.iconId,
      referencedTable: $db.images,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImagesTableAnnotationComposer(
            $db: $db,
            $table: $db.images,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> aiHistoriesRefs<T extends Object>(
    Expression<T> Function($$AiHistoriesTableAnnotationComposer a) f,
  ) {
    final $$AiHistoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.aiHistories,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiHistoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.aiHistories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AiProvidersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AiProvidersTable,
          AiProvider,
          $$AiProvidersTableFilterComposer,
          $$AiProvidersTableOrderingComposer,
          $$AiProvidersTableAnnotationComposer,
          $$AiProvidersTableCreateCompanionBuilder,
          $$AiProvidersTableUpdateCompanionBuilder,
          (AiProvider, $$AiProvidersTableReferences),
          AiProvider,
          PrefetchHooks Function({bool iconId, bool aiHistoriesRefs})
        > {
  $$AiProvidersTableTableManager(_$AppDatabase db, $AiProvidersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiProvidersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiProvidersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiProvidersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> baseUrl = const Value.absent(),
                Value<String> apiKey = const Value.absent(),
                Value<int?> iconId = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> modelsJson = const Value.absent(),
              }) => AiProvidersCompanion(
                id: id,
                name: name,
                description: description,
                baseUrl: baseUrl,
                apiKey: apiKey,
                iconId: iconId,
                isActive: isActive,
                createdAt: createdAt,
                modelsJson: modelsJson,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                required String baseUrl,
                required String apiKey,
                Value<int?> iconId = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> modelsJson = const Value.absent(),
              }) => AiProvidersCompanion.insert(
                id: id,
                name: name,
                description: description,
                baseUrl: baseUrl,
                apiKey: apiKey,
                iconId: iconId,
                isActive: isActive,
                createdAt: createdAt,
                modelsJson: modelsJson,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AiProvidersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({iconId = false, aiHistoriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (aiHistoriesRefs) db.aiHistories],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (iconId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.iconId,
                                referencedTable: $$AiProvidersTableReferences
                                    ._iconIdTable(db),
                                referencedColumn: $$AiProvidersTableReferences
                                    ._iconIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (aiHistoriesRefs)
                    await $_getPrefetchedData<
                      AiProvider,
                      $AiProvidersTable,
                      AiHistory
                    >(
                      currentTable: table,
                      referencedTable: $$AiProvidersTableReferences
                          ._aiHistoriesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$AiProvidersTableReferences(
                            db,
                            table,
                            p0,
                          ).aiHistoriesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.providerId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AiProvidersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AiProvidersTable,
      AiProvider,
      $$AiProvidersTableFilterComposer,
      $$AiProvidersTableOrderingComposer,
      $$AiProvidersTableAnnotationComposer,
      $$AiProvidersTableCreateCompanionBuilder,
      $$AiProvidersTableUpdateCompanionBuilder,
      (AiProvider, $$AiProvidersTableReferences),
      AiProvider,
      PrefetchHooks Function({bool iconId, bool aiHistoriesRefs})
    >;
typedef $$SessionTableCreateCompanionBuilder =
    SessionCompanion Function({
      Value<int> id,
      Value<String?> title,
      Value<DateTime> createdAt,
    });
typedef $$SessionTableUpdateCompanionBuilder =
    SessionCompanion Function({
      Value<int> id,
      Value<String?> title,
      Value<DateTime> createdAt,
    });

final class $$SessionTableReferences
    extends BaseReferences<_$AppDatabase, $SessionTable, SessionData> {
  $$SessionTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AiHistoriesTable, List<AiHistory>>
  _aiHistoriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.aiHistories,
    aliasName: $_aliasNameGenerator(db.session.id, db.aiHistories.sessionId),
  );

  $$AiHistoriesTableProcessedTableManager get aiHistoriesRefs {
    final manager = $$AiHistoriesTableTableManager(
      $_db,
      $_db.aiHistories,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_aiHistoriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SessionTableFilterComposer
    extends Composer<_$AppDatabase, $SessionTable> {
  $$SessionTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> aiHistoriesRefs(
    Expression<bool> Function($$AiHistoriesTableFilterComposer f) f,
  ) {
    final $$AiHistoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.aiHistories,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiHistoriesTableFilterComposer(
            $db: $db,
            $table: $db.aiHistories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionTable> {
  $$SessionTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionTable> {
  $$SessionTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> aiHistoriesRefs<T extends Object>(
    Expression<T> Function($$AiHistoriesTableAnnotationComposer a) f,
  ) {
    final $$AiHistoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.aiHistories,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiHistoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.aiHistories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionTable,
          SessionData,
          $$SessionTableFilterComposer,
          $$SessionTableOrderingComposer,
          $$SessionTableAnnotationComposer,
          $$SessionTableCreateCompanionBuilder,
          $$SessionTableUpdateCompanionBuilder,
          (SessionData, $$SessionTableReferences),
          SessionData,
          PrefetchHooks Function({bool aiHistoriesRefs})
        > {
  $$SessionTableTableManager(_$AppDatabase db, $SessionTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) =>
                  SessionCompanion(id: id, title: title, createdAt: createdAt),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SessionCompanion.insert(
                id: id,
                title: title,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SessionTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({aiHistoriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (aiHistoriesRefs) db.aiHistories],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (aiHistoriesRefs)
                    await $_getPrefetchedData<
                      SessionData,
                      $SessionTable,
                      AiHistory
                    >(
                      currentTable: table,
                      referencedTable: $$SessionTableReferences
                          ._aiHistoriesRefsTable(db),
                      managerFromTypedResult: (p0) => $$SessionTableReferences(
                        db,
                        table,
                        p0,
                      ).aiHistoriesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.sessionId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SessionTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionTable,
      SessionData,
      $$SessionTableFilterComposer,
      $$SessionTableOrderingComposer,
      $$SessionTableAnnotationComposer,
      $$SessionTableCreateCompanionBuilder,
      $$SessionTableUpdateCompanionBuilder,
      (SessionData, $$SessionTableReferences),
      SessionData,
      PrefetchHooks Function({bool aiHistoriesRefs})
    >;
typedef $$AiHistoriesTableCreateCompanionBuilder =
    AiHistoriesCompanion Function({
      Value<int> id,
      Value<int?> sourceId,
      required int providerId,
      required Roles role,
      required int sessionId,
      required String content,
      Value<String?> toolCalls,
      Value<String?> toolCallId,
      Value<int?> tokens,
      Value<DateTime> createdAt,
    });
typedef $$AiHistoriesTableUpdateCompanionBuilder =
    AiHistoriesCompanion Function({
      Value<int> id,
      Value<int?> sourceId,
      Value<int> providerId,
      Value<Roles> role,
      Value<int> sessionId,
      Value<String> content,
      Value<String?> toolCalls,
      Value<String?> toolCallId,
      Value<int?> tokens,
      Value<DateTime> createdAt,
    });

final class $$AiHistoriesTableReferences
    extends BaseReferences<_$AppDatabase, $AiHistoriesTable, AiHistory> {
  $$AiHistoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AiHistoriesTable _sourceIdTable(_$AppDatabase db) =>
      db.aiHistories.createAlias(
        $_aliasNameGenerator(db.aiHistories.sourceId, db.aiHistories.id),
      );

  $$AiHistoriesTableProcessedTableManager? get sourceId {
    final $_column = $_itemColumn<int>('source_id');
    if ($_column == null) return null;
    final manager = $$AiHistoriesTableTableManager(
      $_db,
      $_db.aiHistories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AiProvidersTable _providerIdTable(_$AppDatabase db) =>
      db.aiProviders.createAlias(
        $_aliasNameGenerator(db.aiHistories.providerId, db.aiProviders.id),
      );

  $$AiProvidersTableProcessedTableManager get providerId {
    final $_column = $_itemColumn<int>('provider_id')!;

    final manager = $$AiProvidersTableTableManager(
      $_db,
      $_db.aiProviders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_providerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SessionTable _sessionIdTable(_$AppDatabase db) =>
      db.session.createAlias(
        $_aliasNameGenerator(db.aiHistories.sessionId, db.session.id),
      );

  $$SessionTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<int>('session_id')!;

    final manager = $$SessionTableTableManager(
      $_db,
      $_db.session,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $AiHistoryImagesLinkTable,
    List<AiHistoryImagesLinkData>
  >
  _aiHistoryImagesLinkRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.aiHistoryImagesLink,
        aliasName: $_aliasNameGenerator(
          db.aiHistories.id,
          db.aiHistoryImagesLink.historyId,
        ),
      );

  $$AiHistoryImagesLinkTableProcessedTableManager get aiHistoryImagesLinkRefs {
    final manager = $$AiHistoryImagesLinkTableTableManager(
      $_db,
      $_db.aiHistoryImagesLink,
    ).filter((f) => f.historyId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _aiHistoryImagesLinkRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AiHistoriesTableFilterComposer
    extends Composer<_$AppDatabase, $AiHistoriesTable> {
  $$AiHistoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Roles, Roles, String> get role =>
      $composableBuilder(
        column: $table.role,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toolCalls => $composableBuilder(
    column: $table.toolCalls,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toolCallId => $composableBuilder(
    column: $table.toolCallId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tokens => $composableBuilder(
    column: $table.tokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AiHistoriesTableFilterComposer get sourceId {
    final $$AiHistoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceId,
      referencedTable: $db.aiHistories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiHistoriesTableFilterComposer(
            $db: $db,
            $table: $db.aiHistories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AiProvidersTableFilterComposer get providerId {
    final $$AiProvidersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.aiProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiProvidersTableFilterComposer(
            $db: $db,
            $table: $db.aiProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SessionTableFilterComposer get sessionId {
    final $$SessionTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.session,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionTableFilterComposer(
            $db: $db,
            $table: $db.session,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> aiHistoryImagesLinkRefs(
    Expression<bool> Function($$AiHistoryImagesLinkTableFilterComposer f) f,
  ) {
    final $$AiHistoryImagesLinkTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.aiHistoryImagesLink,
      getReferencedColumn: (t) => t.historyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiHistoryImagesLinkTableFilterComposer(
            $db: $db,
            $table: $db.aiHistoryImagesLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AiHistoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $AiHistoriesTable> {
  $$AiHistoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toolCalls => $composableBuilder(
    column: $table.toolCalls,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toolCallId => $composableBuilder(
    column: $table.toolCallId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tokens => $composableBuilder(
    column: $table.tokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AiHistoriesTableOrderingComposer get sourceId {
    final $$AiHistoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceId,
      referencedTable: $db.aiHistories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiHistoriesTableOrderingComposer(
            $db: $db,
            $table: $db.aiHistories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AiProvidersTableOrderingComposer get providerId {
    final $$AiProvidersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.aiProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiProvidersTableOrderingComposer(
            $db: $db,
            $table: $db.aiProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SessionTableOrderingComposer get sessionId {
    final $$SessionTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.session,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionTableOrderingComposer(
            $db: $db,
            $table: $db.session,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AiHistoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AiHistoriesTable> {
  $$AiHistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Roles, String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get toolCalls =>
      $composableBuilder(column: $table.toolCalls, builder: (column) => column);

  GeneratedColumn<String> get toolCallId => $composableBuilder(
    column: $table.toolCallId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tokens =>
      $composableBuilder(column: $table.tokens, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$AiHistoriesTableAnnotationComposer get sourceId {
    final $$AiHistoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceId,
      referencedTable: $db.aiHistories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiHistoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.aiHistories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AiProvidersTableAnnotationComposer get providerId {
    final $$AiProvidersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.aiProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiProvidersTableAnnotationComposer(
            $db: $db,
            $table: $db.aiProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SessionTableAnnotationComposer get sessionId {
    final $$SessionTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.session,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionTableAnnotationComposer(
            $db: $db,
            $table: $db.session,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> aiHistoryImagesLinkRefs<T extends Object>(
    Expression<T> Function($$AiHistoryImagesLinkTableAnnotationComposer a) f,
  ) {
    final $$AiHistoryImagesLinkTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.aiHistoryImagesLink,
          getReferencedColumn: (t) => t.historyId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AiHistoryImagesLinkTableAnnotationComposer(
                $db: $db,
                $table: $db.aiHistoryImagesLink,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$AiHistoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AiHistoriesTable,
          AiHistory,
          $$AiHistoriesTableFilterComposer,
          $$AiHistoriesTableOrderingComposer,
          $$AiHistoriesTableAnnotationComposer,
          $$AiHistoriesTableCreateCompanionBuilder,
          $$AiHistoriesTableUpdateCompanionBuilder,
          (AiHistory, $$AiHistoriesTableReferences),
          AiHistory,
          PrefetchHooks Function({
            bool sourceId,
            bool providerId,
            bool sessionId,
            bool aiHistoryImagesLinkRefs,
          })
        > {
  $$AiHistoriesTableTableManager(_$AppDatabase db, $AiHistoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiHistoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiHistoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiHistoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> sourceId = const Value.absent(),
                Value<int> providerId = const Value.absent(),
                Value<Roles> role = const Value.absent(),
                Value<int> sessionId = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String?> toolCalls = const Value.absent(),
                Value<String?> toolCallId = const Value.absent(),
                Value<int?> tokens = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AiHistoriesCompanion(
                id: id,
                sourceId: sourceId,
                providerId: providerId,
                role: role,
                sessionId: sessionId,
                content: content,
                toolCalls: toolCalls,
                toolCallId: toolCallId,
                tokens: tokens,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> sourceId = const Value.absent(),
                required int providerId,
                required Roles role,
                required int sessionId,
                required String content,
                Value<String?> toolCalls = const Value.absent(),
                Value<String?> toolCallId = const Value.absent(),
                Value<int?> tokens = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AiHistoriesCompanion.insert(
                id: id,
                sourceId: sourceId,
                providerId: providerId,
                role: role,
                sessionId: sessionId,
                content: content,
                toolCalls: toolCalls,
                toolCallId: toolCallId,
                tokens: tokens,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AiHistoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                sourceId = false,
                providerId = false,
                sessionId = false,
                aiHistoryImagesLinkRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (aiHistoryImagesLinkRefs) db.aiHistoryImagesLink,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (sourceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sourceId,
                                    referencedTable:
                                        $$AiHistoriesTableReferences
                                            ._sourceIdTable(db),
                                    referencedColumn:
                                        $$AiHistoriesTableReferences
                                            ._sourceIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (providerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.providerId,
                                    referencedTable:
                                        $$AiHistoriesTableReferences
                                            ._providerIdTable(db),
                                    referencedColumn:
                                        $$AiHistoriesTableReferences
                                            ._providerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (sessionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sessionId,
                                    referencedTable:
                                        $$AiHistoriesTableReferences
                                            ._sessionIdTable(db),
                                    referencedColumn:
                                        $$AiHistoriesTableReferences
                                            ._sessionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (aiHistoryImagesLinkRefs)
                        await $_getPrefetchedData<
                          AiHistory,
                          $AiHistoriesTable,
                          AiHistoryImagesLinkData
                        >(
                          currentTable: table,
                          referencedTable: $$AiHistoriesTableReferences
                              ._aiHistoryImagesLinkRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AiHistoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).aiHistoryImagesLinkRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.historyId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AiHistoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AiHistoriesTable,
      AiHistory,
      $$AiHistoriesTableFilterComposer,
      $$AiHistoriesTableOrderingComposer,
      $$AiHistoriesTableAnnotationComposer,
      $$AiHistoriesTableCreateCompanionBuilder,
      $$AiHistoriesTableUpdateCompanionBuilder,
      (AiHistory, $$AiHistoriesTableReferences),
      AiHistory,
      PrefetchHooks Function({
        bool sourceId,
        bool providerId,
        bool sessionId,
        bool aiHistoryImagesLinkRefs,
      })
    >;
typedef $$PromptsTableCreateCompanionBuilder =
    PromptsCompanion Function({
      Value<int> id,
      Value<String?> name,
      Value<String?> desc,
      required String content,
    });
typedef $$PromptsTableUpdateCompanionBuilder =
    PromptsCompanion Function({
      Value<int> id,
      Value<String?> name,
      Value<String?> desc,
      Value<String> content,
    });

class $$PromptsTableFilterComposer
    extends Composer<_$AppDatabase, $PromptsTable> {
  $$PromptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get desc => $composableBuilder(
    column: $table.desc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PromptsTableOrderingComposer
    extends Composer<_$AppDatabase, $PromptsTable> {
  $$PromptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get desc => $composableBuilder(
    column: $table.desc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PromptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PromptsTable> {
  $$PromptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get desc =>
      $composableBuilder(column: $table.desc, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);
}

class $$PromptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PromptsTable,
          Prompt,
          $$PromptsTableFilterComposer,
          $$PromptsTableOrderingComposer,
          $$PromptsTableAnnotationComposer,
          $$PromptsTableCreateCompanionBuilder,
          $$PromptsTableUpdateCompanionBuilder,
          (Prompt, BaseReferences<_$AppDatabase, $PromptsTable, Prompt>),
          Prompt,
          PrefetchHooks Function()
        > {
  $$PromptsTableTableManager(_$AppDatabase db, $PromptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PromptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PromptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PromptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> desc = const Value.absent(),
                Value<String> content = const Value.absent(),
              }) => PromptsCompanion(
                id: id,
                name: name,
                desc: desc,
                content: content,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> desc = const Value.absent(),
                required String content,
              }) => PromptsCompanion.insert(
                id: id,
                name: name,
                desc: desc,
                content: content,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PromptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PromptsTable,
      Prompt,
      $$PromptsTableFilterComposer,
      $$PromptsTableOrderingComposer,
      $$PromptsTableAnnotationComposer,
      $$PromptsTableCreateCompanionBuilder,
      $$PromptsTableUpdateCompanionBuilder,
      (Prompt, BaseReferences<_$AppDatabase, $PromptsTable, Prompt>),
      Prompt,
      PrefetchHooks Function()
    >;
typedef $$AiHistoryImagesLinkTableCreateCompanionBuilder =
    AiHistoryImagesLinkCompanion Function({
      Value<int> id,
      required int historyId,
      required int imageId,
      Value<DateTime> createdAt,
    });
typedef $$AiHistoryImagesLinkTableUpdateCompanionBuilder =
    AiHistoryImagesLinkCompanion Function({
      Value<int> id,
      Value<int> historyId,
      Value<int> imageId,
      Value<DateTime> createdAt,
    });

final class $$AiHistoryImagesLinkTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $AiHistoryImagesLinkTable,
          AiHistoryImagesLinkData
        > {
  $$AiHistoryImagesLinkTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AiHistoriesTable _historyIdTable(_$AppDatabase db) =>
      db.aiHistories.createAlias(
        $_aliasNameGenerator(
          db.aiHistoryImagesLink.historyId,
          db.aiHistories.id,
        ),
      );

  $$AiHistoriesTableProcessedTableManager get historyId {
    final $_column = $_itemColumn<int>('history_id')!;

    final manager = $$AiHistoriesTableTableManager(
      $_db,
      $_db.aiHistories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_historyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ImagesTable _imageIdTable(_$AppDatabase db) => db.images.createAlias(
    $_aliasNameGenerator(db.aiHistoryImagesLink.imageId, db.images.id),
  );

  $$ImagesTableProcessedTableManager get imageId {
    final $_column = $_itemColumn<int>('image_id')!;

    final manager = $$ImagesTableTableManager(
      $_db,
      $_db.images,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_imageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AiHistoryImagesLinkTableFilterComposer
    extends Composer<_$AppDatabase, $AiHistoryImagesLinkTable> {
  $$AiHistoryImagesLinkTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AiHistoriesTableFilterComposer get historyId {
    final $$AiHistoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.historyId,
      referencedTable: $db.aiHistories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiHistoriesTableFilterComposer(
            $db: $db,
            $table: $db.aiHistories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ImagesTableFilterComposer get imageId {
    final $$ImagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.imageId,
      referencedTable: $db.images,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImagesTableFilterComposer(
            $db: $db,
            $table: $db.images,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AiHistoryImagesLinkTableOrderingComposer
    extends Composer<_$AppDatabase, $AiHistoryImagesLinkTable> {
  $$AiHistoryImagesLinkTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AiHistoriesTableOrderingComposer get historyId {
    final $$AiHistoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.historyId,
      referencedTable: $db.aiHistories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiHistoriesTableOrderingComposer(
            $db: $db,
            $table: $db.aiHistories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ImagesTableOrderingComposer get imageId {
    final $$ImagesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.imageId,
      referencedTable: $db.images,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImagesTableOrderingComposer(
            $db: $db,
            $table: $db.images,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AiHistoryImagesLinkTableAnnotationComposer
    extends Composer<_$AppDatabase, $AiHistoryImagesLinkTable> {
  $$AiHistoryImagesLinkTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$AiHistoriesTableAnnotationComposer get historyId {
    final $$AiHistoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.historyId,
      referencedTable: $db.aiHistories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiHistoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.aiHistories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ImagesTableAnnotationComposer get imageId {
    final $$ImagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.imageId,
      referencedTable: $db.images,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImagesTableAnnotationComposer(
            $db: $db,
            $table: $db.images,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AiHistoryImagesLinkTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AiHistoryImagesLinkTable,
          AiHistoryImagesLinkData,
          $$AiHistoryImagesLinkTableFilterComposer,
          $$AiHistoryImagesLinkTableOrderingComposer,
          $$AiHistoryImagesLinkTableAnnotationComposer,
          $$AiHistoryImagesLinkTableCreateCompanionBuilder,
          $$AiHistoryImagesLinkTableUpdateCompanionBuilder,
          (AiHistoryImagesLinkData, $$AiHistoryImagesLinkTableReferences),
          AiHistoryImagesLinkData,
          PrefetchHooks Function({bool historyId, bool imageId})
        > {
  $$AiHistoryImagesLinkTableTableManager(
    _$AppDatabase db,
    $AiHistoryImagesLinkTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiHistoryImagesLinkTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiHistoryImagesLinkTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$AiHistoryImagesLinkTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> historyId = const Value.absent(),
                Value<int> imageId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AiHistoryImagesLinkCompanion(
                id: id,
                historyId: historyId,
                imageId: imageId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int historyId,
                required int imageId,
                Value<DateTime> createdAt = const Value.absent(),
              }) => AiHistoryImagesLinkCompanion.insert(
                id: id,
                historyId: historyId,
                imageId: imageId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AiHistoryImagesLinkTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({historyId = false, imageId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (historyId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.historyId,
                                referencedTable:
                                    $$AiHistoryImagesLinkTableReferences
                                        ._historyIdTable(db),
                                referencedColumn:
                                    $$AiHistoryImagesLinkTableReferences
                                        ._historyIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (imageId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.imageId,
                                referencedTable:
                                    $$AiHistoryImagesLinkTableReferences
                                        ._imageIdTable(db),
                                referencedColumn:
                                    $$AiHistoryImagesLinkTableReferences
                                        ._imageIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AiHistoryImagesLinkTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AiHistoryImagesLinkTable,
      AiHistoryImagesLinkData,
      $$AiHistoryImagesLinkTableFilterComposer,
      $$AiHistoryImagesLinkTableOrderingComposer,
      $$AiHistoryImagesLinkTableAnnotationComposer,
      $$AiHistoryImagesLinkTableCreateCompanionBuilder,
      $$AiHistoryImagesLinkTableUpdateCompanionBuilder,
      (AiHistoryImagesLinkData, $$AiHistoryImagesLinkTableReferences),
      AiHistoryImagesLinkData,
      PrefetchHooks Function({bool historyId, bool imageId})
    >;
typedef $$TagsTableCreateCompanionBuilder =
    TagsCompanion Function({
      Value<int> id,
      Value<Subject?> subject,
      required String tag,
      Value<int?> color,
      Value<String?> description,
    });
typedef $$TagsTableUpdateCompanionBuilder =
    TagsCompanion Function({
      Value<int> id,
      Value<Subject?> subject,
      Value<String> tag,
      Value<int?> color,
      Value<String?> description,
    });

final class $$TagsTableReferences
    extends BaseReferences<_$AppDatabase, $TagsTable, Tag> {
  $$TagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WordTagLinkTable, List<WordTagLinkData>>
  _wordTagLinkRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.wordTagLink,
    aliasName: $_aliasNameGenerator(db.tags.id, db.wordTagLink.tagID),
  );

  $$WordTagLinkTableProcessedTableManager get wordTagLinkRefs {
    final manager = $$WordTagLinkTableTableManager(
      $_db,
      $_db.wordTagLink,
    ).filter((f) => f.tagID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_wordTagLinkRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PhrasesTagLinkTable, List<PhrasesTagLinkData>>
  _phrasesTagLinkRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.phrasesTagLink,
    aliasName: $_aliasNameGenerator(db.tags.id, db.phrasesTagLink.tagID),
  );

  $$PhrasesTagLinkTableProcessedTableManager get phrasesTagLinkRefs {
    final manager = $$PhrasesTagLinkTableTableManager(
      $_db,
      $_db.phrasesTagLink,
    ).filter((f) => f.tagID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_phrasesTagLinkRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$KnowledgeTagLinkTable, List<KnowledgeTagLinkData>>
  _knowledgeTagLinkRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.knowledgeTagLink,
    aliasName: $_aliasNameGenerator(db.tags.id, db.knowledgeTagLink.tagID),
  );

  $$KnowledgeTagLinkTableProcessedTableManager get knowledgeTagLinkRefs {
    final manager = $$KnowledgeTagLinkTableTableManager(
      $_db,
      $_db.knowledgeTagLink,
    ).filter((f) => f.tagID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _knowledgeTagLinkRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$QuestionsTagLinkTable, List<QuestionsTagLinkData>>
  _questionsTagLinkRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.questionsTagLink,
    aliasName: $_aliasNameGenerator(db.tags.id, db.questionsTagLink.tagID),
  );

  $$QuestionsTagLinkTableProcessedTableManager get questionsTagLinkRefs {
    final manager = $$QuestionsTagLinkTableTableManager(
      $_db,
      $_db.questionsTagLink,
    ).filter((f) => f.tagID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _questionsTagLinkRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AnswersTagsLinkTable, List<AnswersTagsLinkData>>
  _answersTagsLinkRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.answersTagsLink,
    aliasName: $_aliasNameGenerator(db.tags.id, db.answersTagsLink.tagID),
  );

  $$AnswersTagsLinkTableProcessedTableManager get answersTagsLinkRefs {
    final manager = $$AnswersTagsLinkTableTableManager(
      $_db,
      $_db.answersTagsLink,
    ).filter((f) => f.tagID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _answersTagsLinkRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TagsTableFilterComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Subject?, Subject, String> get subject =>
      $composableBuilder(
        column: $table.subject,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get tag => $composableBuilder(
    column: $table.tag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> wordTagLinkRefs(
    Expression<bool> Function($$WordTagLinkTableFilterComposer f) f,
  ) {
    final $$WordTagLinkTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordTagLink,
      getReferencedColumn: (t) => t.tagID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordTagLinkTableFilterComposer(
            $db: $db,
            $table: $db.wordTagLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> phrasesTagLinkRefs(
    Expression<bool> Function($$PhrasesTagLinkTableFilterComposer f) f,
  ) {
    final $$PhrasesTagLinkTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phrasesTagLink,
      getReferencedColumn: (t) => t.tagID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhrasesTagLinkTableFilterComposer(
            $db: $db,
            $table: $db.phrasesTagLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> knowledgeTagLinkRefs(
    Expression<bool> Function($$KnowledgeTagLinkTableFilterComposer f) f,
  ) {
    final $$KnowledgeTagLinkTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.knowledgeTagLink,
      getReferencedColumn: (t) => t.tagID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeTagLinkTableFilterComposer(
            $db: $db,
            $table: $db.knowledgeTagLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> questionsTagLinkRefs(
    Expression<bool> Function($$QuestionsTagLinkTableFilterComposer f) f,
  ) {
    final $$QuestionsTagLinkTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionsTagLink,
      getReferencedColumn: (t) => t.tagID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTagLinkTableFilterComposer(
            $db: $db,
            $table: $db.questionsTagLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> answersTagsLinkRefs(
    Expression<bool> Function($$AnswersTagsLinkTableFilterComposer f) f,
  ) {
    final $$AnswersTagsLinkTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.answersTagsLink,
      getReferencedColumn: (t) => t.tagID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnswersTagsLinkTableFilterComposer(
            $db: $db,
            $table: $db.answersTagsLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableOrderingComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tag => $composableBuilder(
    column: $table.tag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Subject?, String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<String> get tag =>
      $composableBuilder(column: $table.tag, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  Expression<T> wordTagLinkRefs<T extends Object>(
    Expression<T> Function($$WordTagLinkTableAnnotationComposer a) f,
  ) {
    final $$WordTagLinkTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordTagLink,
      getReferencedColumn: (t) => t.tagID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordTagLinkTableAnnotationComposer(
            $db: $db,
            $table: $db.wordTagLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> phrasesTagLinkRefs<T extends Object>(
    Expression<T> Function($$PhrasesTagLinkTableAnnotationComposer a) f,
  ) {
    final $$PhrasesTagLinkTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phrasesTagLink,
      getReferencedColumn: (t) => t.tagID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhrasesTagLinkTableAnnotationComposer(
            $db: $db,
            $table: $db.phrasesTagLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> knowledgeTagLinkRefs<T extends Object>(
    Expression<T> Function($$KnowledgeTagLinkTableAnnotationComposer a) f,
  ) {
    final $$KnowledgeTagLinkTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.knowledgeTagLink,
      getReferencedColumn: (t) => t.tagID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeTagLinkTableAnnotationComposer(
            $db: $db,
            $table: $db.knowledgeTagLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> questionsTagLinkRefs<T extends Object>(
    Expression<T> Function($$QuestionsTagLinkTableAnnotationComposer a) f,
  ) {
    final $$QuestionsTagLinkTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionsTagLink,
      getReferencedColumn: (t) => t.tagID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTagLinkTableAnnotationComposer(
            $db: $db,
            $table: $db.questionsTagLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> answersTagsLinkRefs<T extends Object>(
    Expression<T> Function($$AnswersTagsLinkTableAnnotationComposer a) f,
  ) {
    final $$AnswersTagsLinkTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.answersTagsLink,
      getReferencedColumn: (t) => t.tagID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnswersTagsLinkTableAnnotationComposer(
            $db: $db,
            $table: $db.answersTagsLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TagsTable,
          Tag,
          $$TagsTableFilterComposer,
          $$TagsTableOrderingComposer,
          $$TagsTableAnnotationComposer,
          $$TagsTableCreateCompanionBuilder,
          $$TagsTableUpdateCompanionBuilder,
          (Tag, $$TagsTableReferences),
          Tag,
          PrefetchHooks Function({
            bool wordTagLinkRefs,
            bool phrasesTagLinkRefs,
            bool knowledgeTagLinkRefs,
            bool questionsTagLinkRefs,
            bool answersTagsLinkRefs,
          })
        > {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<Subject?> subject = const Value.absent(),
                Value<String> tag = const Value.absent(),
                Value<int?> color = const Value.absent(),
                Value<String?> description = const Value.absent(),
              }) => TagsCompanion(
                id: id,
                subject: subject,
                tag: tag,
                color: color,
                description: description,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<Subject?> subject = const Value.absent(),
                required String tag,
                Value<int?> color = const Value.absent(),
                Value<String?> description = const Value.absent(),
              }) => TagsCompanion.insert(
                id: id,
                subject: subject,
                tag: tag,
                color: color,
                description: description,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TagsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                wordTagLinkRefs = false,
                phrasesTagLinkRefs = false,
                knowledgeTagLinkRefs = false,
                questionsTagLinkRefs = false,
                answersTagsLinkRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (wordTagLinkRefs) db.wordTagLink,
                    if (phrasesTagLinkRefs) db.phrasesTagLink,
                    if (knowledgeTagLinkRefs) db.knowledgeTagLink,
                    if (questionsTagLinkRefs) db.questionsTagLink,
                    if (answersTagsLinkRefs) db.answersTagsLink,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (wordTagLinkRefs)
                        await $_getPrefetchedData<
                          Tag,
                          $TagsTable,
                          WordTagLinkData
                        >(
                          currentTable: table,
                          referencedTable: $$TagsTableReferences
                              ._wordTagLinkRefsTable(db),
                          managerFromTypedResult: (p0) => $$TagsTableReferences(
                            db,
                            table,
                            p0,
                          ).wordTagLinkRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tagID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (phrasesTagLinkRefs)
                        await $_getPrefetchedData<
                          Tag,
                          $TagsTable,
                          PhrasesTagLinkData
                        >(
                          currentTable: table,
                          referencedTable: $$TagsTableReferences
                              ._phrasesTagLinkRefsTable(db),
                          managerFromTypedResult: (p0) => $$TagsTableReferences(
                            db,
                            table,
                            p0,
                          ).phrasesTagLinkRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tagID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (knowledgeTagLinkRefs)
                        await $_getPrefetchedData<
                          Tag,
                          $TagsTable,
                          KnowledgeTagLinkData
                        >(
                          currentTable: table,
                          referencedTable: $$TagsTableReferences
                              ._knowledgeTagLinkRefsTable(db),
                          managerFromTypedResult: (p0) => $$TagsTableReferences(
                            db,
                            table,
                            p0,
                          ).knowledgeTagLinkRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tagID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (questionsTagLinkRefs)
                        await $_getPrefetchedData<
                          Tag,
                          $TagsTable,
                          QuestionsTagLinkData
                        >(
                          currentTable: table,
                          referencedTable: $$TagsTableReferences
                              ._questionsTagLinkRefsTable(db),
                          managerFromTypedResult: (p0) => $$TagsTableReferences(
                            db,
                            table,
                            p0,
                          ).questionsTagLinkRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tagID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (answersTagsLinkRefs)
                        await $_getPrefetchedData<
                          Tag,
                          $TagsTable,
                          AnswersTagsLinkData
                        >(
                          currentTable: table,
                          referencedTable: $$TagsTableReferences
                              ._answersTagsLinkRefsTable(db),
                          managerFromTypedResult: (p0) => $$TagsTableReferences(
                            db,
                            table,
                            p0,
                          ).answersTagsLinkRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tagID == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TagsTable,
      Tag,
      $$TagsTableFilterComposer,
      $$TagsTableOrderingComposer,
      $$TagsTableAnnotationComposer,
      $$TagsTableCreateCompanionBuilder,
      $$TagsTableUpdateCompanionBuilder,
      (Tag, $$TagsTableReferences),
      Tag,
      PrefetchHooks Function({
        bool wordTagLinkRefs,
        bool phrasesTagLinkRefs,
        bool knowledgeTagLinkRefs,
        bool questionsTagLinkRefs,
        bool answersTagsLinkRefs,
      })
    >;
typedef $$WordsTableCreateCompanionBuilder =
    WordsCompanion Function({
      Value<int> id,
      required String word,
      Value<String?> definitionPreview,
      Value<String?> definition,
      Value<DateTime> createdAt,
    });
typedef $$WordsTableUpdateCompanionBuilder =
    WordsCompanion Function({
      Value<int> id,
      Value<String> word,
      Value<String?> definitionPreview,
      Value<String?> definition,
      Value<DateTime> createdAt,
    });

final class $$WordsTableReferences
    extends BaseReferences<_$AppDatabase, $WordsTable, Word> {
  $$WordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WordLogsTable, List<WordLog>> _wordLogsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.wordLogs,
    aliasName: $_aliasNameGenerator(db.words.id, db.wordLogs.wordID),
  );

  $$WordLogsTableProcessedTableManager get wordLogsRefs {
    final manager = $$WordLogsTableTableManager(
      $_db,
      $_db.wordLogs,
    ).filter((f) => f.wordID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_wordLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WordTagLinkTable, List<WordTagLinkData>>
  _wordTagLinkRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.wordTagLink,
    aliasName: $_aliasNameGenerator(db.words.id, db.wordTagLink.wordID),
  );

  $$WordTagLinkTableProcessedTableManager get wordTagLinkRefs {
    final manager = $$WordTagLinkTableTableManager(
      $_db,
      $_db.wordTagLink,
    ).filter((f) => f.wordID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_wordTagLinkRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PhrasesTable, List<Phrase>> _phrasesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.phrases,
    aliasName: $_aliasNameGenerator(db.words.id, db.phrases.wordID),
  );

  $$PhrasesTableProcessedTableManager get phrasesRefs {
    final manager = $$PhrasesTableTableManager(
      $_db,
      $_db.phrases,
    ).filter((f) => f.wordID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_phrasesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WordsTableFilterComposer extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get definitionPreview => $composableBuilder(
    column: $table.definitionPreview,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> wordLogsRefs(
    Expression<bool> Function($$WordLogsTableFilterComposer f) f,
  ) {
    final $$WordLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordLogs,
      getReferencedColumn: (t) => t.wordID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordLogsTableFilterComposer(
            $db: $db,
            $table: $db.wordLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> wordTagLinkRefs(
    Expression<bool> Function($$WordTagLinkTableFilterComposer f) f,
  ) {
    final $$WordTagLinkTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordTagLink,
      getReferencedColumn: (t) => t.wordID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordTagLinkTableFilterComposer(
            $db: $db,
            $table: $db.wordTagLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> phrasesRefs(
    Expression<bool> Function($$PhrasesTableFilterComposer f) f,
  ) {
    final $$PhrasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phrases,
      getReferencedColumn: (t) => t.wordID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhrasesTableFilterComposer(
            $db: $db,
            $table: $db.phrases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WordsTableOrderingComposer
    extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get definitionPreview => $composableBuilder(
    column: $table.definitionPreview,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<String> get definitionPreview => $composableBuilder(
    column: $table.definitionPreview,
    builder: (column) => column,
  );

  GeneratedColumn<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> wordLogsRefs<T extends Object>(
    Expression<T> Function($$WordLogsTableAnnotationComposer a) f,
  ) {
    final $$WordLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordLogs,
      getReferencedColumn: (t) => t.wordID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.wordLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> wordTagLinkRefs<T extends Object>(
    Expression<T> Function($$WordTagLinkTableAnnotationComposer a) f,
  ) {
    final $$WordTagLinkTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordTagLink,
      getReferencedColumn: (t) => t.wordID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordTagLinkTableAnnotationComposer(
            $db: $db,
            $table: $db.wordTagLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> phrasesRefs<T extends Object>(
    Expression<T> Function($$PhrasesTableAnnotationComposer a) f,
  ) {
    final $$PhrasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phrases,
      getReferencedColumn: (t) => t.wordID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhrasesTableAnnotationComposer(
            $db: $db,
            $table: $db.phrases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordsTable,
          Word,
          $$WordsTableFilterComposer,
          $$WordsTableOrderingComposer,
          $$WordsTableAnnotationComposer,
          $$WordsTableCreateCompanionBuilder,
          $$WordsTableUpdateCompanionBuilder,
          (Word, $$WordsTableReferences),
          Word,
          PrefetchHooks Function({
            bool wordLogsRefs,
            bool wordTagLinkRefs,
            bool phrasesRefs,
          })
        > {
  $$WordsTableTableManager(_$AppDatabase db, $WordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> word = const Value.absent(),
                Value<String?> definitionPreview = const Value.absent(),
                Value<String?> definition = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => WordsCompanion(
                id: id,
                word: word,
                definitionPreview: definitionPreview,
                definition: definition,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String word,
                Value<String?> definitionPreview = const Value.absent(),
                Value<String?> definition = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => WordsCompanion.insert(
                id: id,
                word: word,
                definitionPreview: definitionPreview,
                definition: definition,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$WordsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                wordLogsRefs = false,
                wordTagLinkRefs = false,
                phrasesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (wordLogsRefs) db.wordLogs,
                    if (wordTagLinkRefs) db.wordTagLink,
                    if (phrasesRefs) db.phrases,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (wordLogsRefs)
                        await $_getPrefetchedData<Word, $WordsTable, WordLog>(
                          currentTable: table,
                          referencedTable: $$WordsTableReferences
                              ._wordLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WordsTableReferences(
                                db,
                                table,
                                p0,
                              ).wordLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.wordID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (wordTagLinkRefs)
                        await $_getPrefetchedData<
                          Word,
                          $WordsTable,
                          WordTagLinkData
                        >(
                          currentTable: table,
                          referencedTable: $$WordsTableReferences
                              ._wordTagLinkRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WordsTableReferences(
                                db,
                                table,
                                p0,
                              ).wordTagLinkRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.wordID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (phrasesRefs)
                        await $_getPrefetchedData<Word, $WordsTable, Phrase>(
                          currentTable: table,
                          referencedTable: $$WordsTableReferences
                              ._phrasesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WordsTableReferences(db, table, p0).phrasesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.wordID == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordsTable,
      Word,
      $$WordsTableFilterComposer,
      $$WordsTableOrderingComposer,
      $$WordsTableAnnotationComposer,
      $$WordsTableCreateCompanionBuilder,
      $$WordsTableUpdateCompanionBuilder,
      (Word, $$WordsTableReferences),
      Word,
      PrefetchHooks Function({
        bool wordLogsRefs,
        bool wordTagLinkRefs,
        bool phrasesRefs,
      })
    >;
typedef $$WordLogsTableCreateCompanionBuilder =
    WordLogsCompanion Function({
      Value<int> id,
      required int wordID,
      required EnglishLogType type,
      Value<DateTime> timestamp,
      Value<String?> notes,
    });
typedef $$WordLogsTableUpdateCompanionBuilder =
    WordLogsCompanion Function({
      Value<int> id,
      Value<int> wordID,
      Value<EnglishLogType> type,
      Value<DateTime> timestamp,
      Value<String?> notes,
    });

final class $$WordLogsTableReferences
    extends BaseReferences<_$AppDatabase, $WordLogsTable, WordLog> {
  $$WordLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WordsTable _wordIDTable(_$AppDatabase db) => db.words.createAlias(
    $_aliasNameGenerator(db.wordLogs.wordID, db.words.id),
  );

  $$WordsTableProcessedTableManager get wordID {
    final $_column = $_itemColumn<int>('word_i_d')!;

    final manager = $$WordsTableTableManager(
      $_db,
      $_db.words,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wordIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WordLogsTableFilterComposer
    extends Composer<_$AppDatabase, $WordLogsTable> {
  $$WordLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<EnglishLogType, EnglishLogType, String>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$WordsTableFilterComposer get wordID {
    final $$WordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordID,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableFilterComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $WordLogsTable> {
  $$WordLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$WordsTableOrderingComposer get wordID {
    final $$WordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordID,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableOrderingComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordLogsTable> {
  $$WordLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<EnglishLogType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$WordsTableAnnotationComposer get wordID {
    final $$WordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordID,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableAnnotationComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordLogsTable,
          WordLog,
          $$WordLogsTableFilterComposer,
          $$WordLogsTableOrderingComposer,
          $$WordLogsTableAnnotationComposer,
          $$WordLogsTableCreateCompanionBuilder,
          $$WordLogsTableUpdateCompanionBuilder,
          (WordLog, $$WordLogsTableReferences),
          WordLog,
          PrefetchHooks Function({bool wordID})
        > {
  $$WordLogsTableTableManager(_$AppDatabase db, $WordLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> wordID = const Value.absent(),
                Value<EnglishLogType> type = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => WordLogsCompanion(
                id: id,
                wordID: wordID,
                type: type,
                timestamp: timestamp,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int wordID,
                required EnglishLogType type,
                Value<DateTime> timestamp = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => WordLogsCompanion.insert(
                id: id,
                wordID: wordID,
                type: type,
                timestamp: timestamp,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WordLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({wordID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (wordID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.wordID,
                                referencedTable: $$WordLogsTableReferences
                                    ._wordIDTable(db),
                                referencedColumn: $$WordLogsTableReferences
                                    ._wordIDTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WordLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordLogsTable,
      WordLog,
      $$WordLogsTableFilterComposer,
      $$WordLogsTableOrderingComposer,
      $$WordLogsTableAnnotationComposer,
      $$WordLogsTableCreateCompanionBuilder,
      $$WordLogsTableUpdateCompanionBuilder,
      (WordLog, $$WordLogsTableReferences),
      WordLog,
      PrefetchHooks Function({bool wordID})
    >;
typedef $$WordTagLinkTableCreateCompanionBuilder =
    WordTagLinkCompanion Function({
      required int wordID,
      required int tagID,
      Value<int> rowid,
    });
typedef $$WordTagLinkTableUpdateCompanionBuilder =
    WordTagLinkCompanion Function({
      Value<int> wordID,
      Value<int> tagID,
      Value<int> rowid,
    });

final class $$WordTagLinkTableReferences
    extends BaseReferences<_$AppDatabase, $WordTagLinkTable, WordTagLinkData> {
  $$WordTagLinkTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WordsTable _wordIDTable(_$AppDatabase db) => db.words.createAlias(
    $_aliasNameGenerator(db.wordTagLink.wordID, db.words.id),
  );

  $$WordsTableProcessedTableManager get wordID {
    final $_column = $_itemColumn<int>('word_i_d')!;

    final manager = $$WordsTableTableManager(
      $_db,
      $_db.words,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wordIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTable _tagIDTable(_$AppDatabase db) => db.tags.createAlias(
    $_aliasNameGenerator(db.wordTagLink.tagID, db.tags.id),
  );

  $$TagsTableProcessedTableManager get tagID {
    final $_column = $_itemColumn<int>('tag_i_d')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WordTagLinkTableFilterComposer
    extends Composer<_$AppDatabase, $WordTagLinkTable> {
  $$WordTagLinkTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$WordsTableFilterComposer get wordID {
    final $$WordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordID,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableFilterComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableFilterComposer get tagID {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordTagLinkTableOrderingComposer
    extends Composer<_$AppDatabase, $WordTagLinkTable> {
  $$WordTagLinkTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$WordsTableOrderingComposer get wordID {
    final $$WordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordID,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableOrderingComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableOrderingComposer get tagID {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordTagLinkTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordTagLinkTable> {
  $$WordTagLinkTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$WordsTableAnnotationComposer get wordID {
    final $$WordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordID,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableAnnotationComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableAnnotationComposer get tagID {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordTagLinkTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordTagLinkTable,
          WordTagLinkData,
          $$WordTagLinkTableFilterComposer,
          $$WordTagLinkTableOrderingComposer,
          $$WordTagLinkTableAnnotationComposer,
          $$WordTagLinkTableCreateCompanionBuilder,
          $$WordTagLinkTableUpdateCompanionBuilder,
          (WordTagLinkData, $$WordTagLinkTableReferences),
          WordTagLinkData,
          PrefetchHooks Function({bool wordID, bool tagID})
        > {
  $$WordTagLinkTableTableManager(_$AppDatabase db, $WordTagLinkTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordTagLinkTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordTagLinkTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordTagLinkTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> wordID = const Value.absent(),
                Value<int> tagID = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WordTagLinkCompanion(
                wordID: wordID,
                tagID: tagID,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int wordID,
                required int tagID,
                Value<int> rowid = const Value.absent(),
              }) => WordTagLinkCompanion.insert(
                wordID: wordID,
                tagID: tagID,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WordTagLinkTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({wordID = false, tagID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (wordID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.wordID,
                                referencedTable: $$WordTagLinkTableReferences
                                    ._wordIDTable(db),
                                referencedColumn: $$WordTagLinkTableReferences
                                    ._wordIDTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (tagID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tagID,
                                referencedTable: $$WordTagLinkTableReferences
                                    ._tagIDTable(db),
                                referencedColumn: $$WordTagLinkTableReferences
                                    ._tagIDTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WordTagLinkTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordTagLinkTable,
      WordTagLinkData,
      $$WordTagLinkTableFilterComposer,
      $$WordTagLinkTableOrderingComposer,
      $$WordTagLinkTableAnnotationComposer,
      $$WordTagLinkTableCreateCompanionBuilder,
      $$WordTagLinkTableUpdateCompanionBuilder,
      (WordTagLinkData, $$WordTagLinkTableReferences),
      WordTagLinkData,
      PrefetchHooks Function({bool wordID, bool tagID})
    >;
typedef $$PhrasesTableCreateCompanionBuilder =
    PhrasesCompanion Function({
      Value<int> id,
      required int wordID,
      required String phrase,
      Value<String?> definition,
      Value<DateTime> createdAt,
    });
typedef $$PhrasesTableUpdateCompanionBuilder =
    PhrasesCompanion Function({
      Value<int> id,
      Value<int> wordID,
      Value<String> phrase,
      Value<String?> definition,
      Value<DateTime> createdAt,
    });

final class $$PhrasesTableReferences
    extends BaseReferences<_$AppDatabase, $PhrasesTable, Phrase> {
  $$PhrasesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WordsTable _wordIDTable(_$AppDatabase db) => db.words.createAlias(
    $_aliasNameGenerator(db.phrases.wordID, db.words.id),
  );

  $$WordsTableProcessedTableManager get wordID {
    final $_column = $_itemColumn<int>('word_i_d')!;

    final manager = $$WordsTableTableManager(
      $_db,
      $_db.words,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wordIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PhrasesTagLinkTable, List<PhrasesTagLinkData>>
  _phrasesTagLinkRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.phrasesTagLink,
    aliasName: $_aliasNameGenerator(db.phrases.id, db.phrasesTagLink.phraseID),
  );

  $$PhrasesTagLinkTableProcessedTableManager get phrasesTagLinkRefs {
    final manager = $$PhrasesTagLinkTableTableManager(
      $_db,
      $_db.phrasesTagLink,
    ).filter((f) => f.phraseID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_phrasesTagLinkRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PhraseLogsTable, List<PhraseLog>>
  _phraseLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.phraseLogs,
    aliasName: $_aliasNameGenerator(db.phrases.id, db.phraseLogs.phraseID),
  );

  $$PhraseLogsTableProcessedTableManager get phraseLogsRefs {
    final manager = $$PhraseLogsTableTableManager(
      $_db,
      $_db.phraseLogs,
    ).filter((f) => f.phraseID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_phraseLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PhrasesTableFilterComposer
    extends Composer<_$AppDatabase, $PhrasesTable> {
  $$PhrasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phrase => $composableBuilder(
    column: $table.phrase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WordsTableFilterComposer get wordID {
    final $$WordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordID,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableFilterComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> phrasesTagLinkRefs(
    Expression<bool> Function($$PhrasesTagLinkTableFilterComposer f) f,
  ) {
    final $$PhrasesTagLinkTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phrasesTagLink,
      getReferencedColumn: (t) => t.phraseID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhrasesTagLinkTableFilterComposer(
            $db: $db,
            $table: $db.phrasesTagLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> phraseLogsRefs(
    Expression<bool> Function($$PhraseLogsTableFilterComposer f) f,
  ) {
    final $$PhraseLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phraseLogs,
      getReferencedColumn: (t) => t.phraseID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhraseLogsTableFilterComposer(
            $db: $db,
            $table: $db.phraseLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PhrasesTableOrderingComposer
    extends Composer<_$AppDatabase, $PhrasesTable> {
  $$PhrasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phrase => $composableBuilder(
    column: $table.phrase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WordsTableOrderingComposer get wordID {
    final $$WordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordID,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableOrderingComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhrasesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhrasesTable> {
  $$PhrasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get phrase =>
      $composableBuilder(column: $table.phrase, builder: (column) => column);

  GeneratedColumn<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$WordsTableAnnotationComposer get wordID {
    final $$WordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordID,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableAnnotationComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> phrasesTagLinkRefs<T extends Object>(
    Expression<T> Function($$PhrasesTagLinkTableAnnotationComposer a) f,
  ) {
    final $$PhrasesTagLinkTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phrasesTagLink,
      getReferencedColumn: (t) => t.phraseID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhrasesTagLinkTableAnnotationComposer(
            $db: $db,
            $table: $db.phrasesTagLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> phraseLogsRefs<T extends Object>(
    Expression<T> Function($$PhraseLogsTableAnnotationComposer a) f,
  ) {
    final $$PhraseLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phraseLogs,
      getReferencedColumn: (t) => t.phraseID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhraseLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.phraseLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PhrasesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PhrasesTable,
          Phrase,
          $$PhrasesTableFilterComposer,
          $$PhrasesTableOrderingComposer,
          $$PhrasesTableAnnotationComposer,
          $$PhrasesTableCreateCompanionBuilder,
          $$PhrasesTableUpdateCompanionBuilder,
          (Phrase, $$PhrasesTableReferences),
          Phrase,
          PrefetchHooks Function({
            bool wordID,
            bool phrasesTagLinkRefs,
            bool phraseLogsRefs,
          })
        > {
  $$PhrasesTableTableManager(_$AppDatabase db, $PhrasesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhrasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhrasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhrasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> wordID = const Value.absent(),
                Value<String> phrase = const Value.absent(),
                Value<String?> definition = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PhrasesCompanion(
                id: id,
                wordID: wordID,
                phrase: phrase,
                definition: definition,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int wordID,
                required String phrase,
                Value<String?> definition = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PhrasesCompanion.insert(
                id: id,
                wordID: wordID,
                phrase: phrase,
                definition: definition,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PhrasesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                wordID = false,
                phrasesTagLinkRefs = false,
                phraseLogsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (phrasesTagLinkRefs) db.phrasesTagLink,
                    if (phraseLogsRefs) db.phraseLogs,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (wordID) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.wordID,
                                    referencedTable: $$PhrasesTableReferences
                                        ._wordIDTable(db),
                                    referencedColumn: $$PhrasesTableReferences
                                        ._wordIDTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (phrasesTagLinkRefs)
                        await $_getPrefetchedData<
                          Phrase,
                          $PhrasesTable,
                          PhrasesTagLinkData
                        >(
                          currentTable: table,
                          referencedTable: $$PhrasesTableReferences
                              ._phrasesTagLinkRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PhrasesTableReferences(
                                db,
                                table,
                                p0,
                              ).phrasesTagLinkRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.phraseID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (phraseLogsRefs)
                        await $_getPrefetchedData<
                          Phrase,
                          $PhrasesTable,
                          PhraseLog
                        >(
                          currentTable: table,
                          referencedTable: $$PhrasesTableReferences
                              ._phraseLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PhrasesTableReferences(
                                db,
                                table,
                                p0,
                              ).phraseLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.phraseID == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PhrasesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PhrasesTable,
      Phrase,
      $$PhrasesTableFilterComposer,
      $$PhrasesTableOrderingComposer,
      $$PhrasesTableAnnotationComposer,
      $$PhrasesTableCreateCompanionBuilder,
      $$PhrasesTableUpdateCompanionBuilder,
      (Phrase, $$PhrasesTableReferences),
      Phrase,
      PrefetchHooks Function({
        bool wordID,
        bool phrasesTagLinkRefs,
        bool phraseLogsRefs,
      })
    >;
typedef $$PhrasesTagLinkTableCreateCompanionBuilder =
    PhrasesTagLinkCompanion Function({
      required int phraseID,
      required int tagID,
      Value<int> rowid,
    });
typedef $$PhrasesTagLinkTableUpdateCompanionBuilder =
    PhrasesTagLinkCompanion Function({
      Value<int> phraseID,
      Value<int> tagID,
      Value<int> rowid,
    });

final class $$PhrasesTagLinkTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PhrasesTagLinkTable,
          PhrasesTagLinkData
        > {
  $$PhrasesTagLinkTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PhrasesTable _phraseIDTable(_$AppDatabase db) =>
      db.phrases.createAlias(
        $_aliasNameGenerator(db.phrasesTagLink.phraseID, db.phrases.id),
      );

  $$PhrasesTableProcessedTableManager get phraseID {
    final $_column = $_itemColumn<int>('phrase_i_d')!;

    final manager = $$PhrasesTableTableManager(
      $_db,
      $_db.phrases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_phraseIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTable _tagIDTable(_$AppDatabase db) => db.tags.createAlias(
    $_aliasNameGenerator(db.phrasesTagLink.tagID, db.tags.id),
  );

  $$TagsTableProcessedTableManager get tagID {
    final $_column = $_itemColumn<int>('tag_i_d')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PhrasesTagLinkTableFilterComposer
    extends Composer<_$AppDatabase, $PhrasesTagLinkTable> {
  $$PhrasesTagLinkTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PhrasesTableFilterComposer get phraseID {
    final $$PhrasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.phraseID,
      referencedTable: $db.phrases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhrasesTableFilterComposer(
            $db: $db,
            $table: $db.phrases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableFilterComposer get tagID {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhrasesTagLinkTableOrderingComposer
    extends Composer<_$AppDatabase, $PhrasesTagLinkTable> {
  $$PhrasesTagLinkTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PhrasesTableOrderingComposer get phraseID {
    final $$PhrasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.phraseID,
      referencedTable: $db.phrases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhrasesTableOrderingComposer(
            $db: $db,
            $table: $db.phrases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableOrderingComposer get tagID {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhrasesTagLinkTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhrasesTagLinkTable> {
  $$PhrasesTagLinkTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PhrasesTableAnnotationComposer get phraseID {
    final $$PhrasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.phraseID,
      referencedTable: $db.phrases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhrasesTableAnnotationComposer(
            $db: $db,
            $table: $db.phrases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableAnnotationComposer get tagID {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhrasesTagLinkTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PhrasesTagLinkTable,
          PhrasesTagLinkData,
          $$PhrasesTagLinkTableFilterComposer,
          $$PhrasesTagLinkTableOrderingComposer,
          $$PhrasesTagLinkTableAnnotationComposer,
          $$PhrasesTagLinkTableCreateCompanionBuilder,
          $$PhrasesTagLinkTableUpdateCompanionBuilder,
          (PhrasesTagLinkData, $$PhrasesTagLinkTableReferences),
          PhrasesTagLinkData,
          PrefetchHooks Function({bool phraseID, bool tagID})
        > {
  $$PhrasesTagLinkTableTableManager(
    _$AppDatabase db,
    $PhrasesTagLinkTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhrasesTagLinkTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhrasesTagLinkTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhrasesTagLinkTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> phraseID = const Value.absent(),
                Value<int> tagID = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhrasesTagLinkCompanion(
                phraseID: phraseID,
                tagID: tagID,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int phraseID,
                required int tagID,
                Value<int> rowid = const Value.absent(),
              }) => PhrasesTagLinkCompanion.insert(
                phraseID: phraseID,
                tagID: tagID,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PhrasesTagLinkTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({phraseID = false, tagID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (phraseID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.phraseID,
                                referencedTable: $$PhrasesTagLinkTableReferences
                                    ._phraseIDTable(db),
                                referencedColumn:
                                    $$PhrasesTagLinkTableReferences
                                        ._phraseIDTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (tagID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tagID,
                                referencedTable: $$PhrasesTagLinkTableReferences
                                    ._tagIDTable(db),
                                referencedColumn:
                                    $$PhrasesTagLinkTableReferences
                                        ._tagIDTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PhrasesTagLinkTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PhrasesTagLinkTable,
      PhrasesTagLinkData,
      $$PhrasesTagLinkTableFilterComposer,
      $$PhrasesTagLinkTableOrderingComposer,
      $$PhrasesTagLinkTableAnnotationComposer,
      $$PhrasesTagLinkTableCreateCompanionBuilder,
      $$PhrasesTagLinkTableUpdateCompanionBuilder,
      (PhrasesTagLinkData, $$PhrasesTagLinkTableReferences),
      PhrasesTagLinkData,
      PrefetchHooks Function({bool phraseID, bool tagID})
    >;
typedef $$PhraseLogsTableCreateCompanionBuilder =
    PhraseLogsCompanion Function({
      Value<int> id,
      required int phraseID,
      required EnglishLogType type,
      Value<DateTime> timestamp,
      Value<String?> notes,
    });
typedef $$PhraseLogsTableUpdateCompanionBuilder =
    PhraseLogsCompanion Function({
      Value<int> id,
      Value<int> phraseID,
      Value<EnglishLogType> type,
      Value<DateTime> timestamp,
      Value<String?> notes,
    });

final class $$PhraseLogsTableReferences
    extends BaseReferences<_$AppDatabase, $PhraseLogsTable, PhraseLog> {
  $$PhraseLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PhrasesTable _phraseIDTable(_$AppDatabase db) => db.phrases
      .createAlias($_aliasNameGenerator(db.phraseLogs.phraseID, db.phrases.id));

  $$PhrasesTableProcessedTableManager get phraseID {
    final $_column = $_itemColumn<int>('phrase_i_d')!;

    final manager = $$PhrasesTableTableManager(
      $_db,
      $_db.phrases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_phraseIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PhraseLogsTableFilterComposer
    extends Composer<_$AppDatabase, $PhraseLogsTable> {
  $$PhraseLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<EnglishLogType, EnglishLogType, String>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$PhrasesTableFilterComposer get phraseID {
    final $$PhrasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.phraseID,
      referencedTable: $db.phrases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhrasesTableFilterComposer(
            $db: $db,
            $table: $db.phrases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhraseLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $PhraseLogsTable> {
  $$PhraseLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$PhrasesTableOrderingComposer get phraseID {
    final $$PhrasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.phraseID,
      referencedTable: $db.phrases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhrasesTableOrderingComposer(
            $db: $db,
            $table: $db.phrases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhraseLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhraseLogsTable> {
  $$PhraseLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<EnglishLogType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$PhrasesTableAnnotationComposer get phraseID {
    final $$PhrasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.phraseID,
      referencedTable: $db.phrases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhrasesTableAnnotationComposer(
            $db: $db,
            $table: $db.phrases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhraseLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PhraseLogsTable,
          PhraseLog,
          $$PhraseLogsTableFilterComposer,
          $$PhraseLogsTableOrderingComposer,
          $$PhraseLogsTableAnnotationComposer,
          $$PhraseLogsTableCreateCompanionBuilder,
          $$PhraseLogsTableUpdateCompanionBuilder,
          (PhraseLog, $$PhraseLogsTableReferences),
          PhraseLog,
          PrefetchHooks Function({bool phraseID})
        > {
  $$PhraseLogsTableTableManager(_$AppDatabase db, $PhraseLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhraseLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhraseLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhraseLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> phraseID = const Value.absent(),
                Value<EnglishLogType> type = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PhraseLogsCompanion(
                id: id,
                phraseID: phraseID,
                type: type,
                timestamp: timestamp,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int phraseID,
                required EnglishLogType type,
                Value<DateTime> timestamp = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PhraseLogsCompanion.insert(
                id: id,
                phraseID: phraseID,
                type: type,
                timestamp: timestamp,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PhraseLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({phraseID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (phraseID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.phraseID,
                                referencedTable: $$PhraseLogsTableReferences
                                    ._phraseIDTable(db),
                                referencedColumn: $$PhraseLogsTableReferences
                                    ._phraseIDTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PhraseLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PhraseLogsTable,
      PhraseLog,
      $$PhraseLogsTableFilterComposer,
      $$PhraseLogsTableOrderingComposer,
      $$PhraseLogsTableAnnotationComposer,
      $$PhraseLogsTableCreateCompanionBuilder,
      $$PhraseLogsTableUpdateCompanionBuilder,
      (PhraseLog, $$PhraseLogsTableReferences),
      PhraseLog,
      PrefetchHooks Function({bool phraseID})
    >;
typedef $$KnowledgeTableCreateCompanionBuilder =
    KnowledgeCompanion Function({
      Value<int> id,
      required Subject subject,
      required String head,
      required String body,
      Value<DateTime> createdAt,
    });
typedef $$KnowledgeTableUpdateCompanionBuilder =
    KnowledgeCompanion Function({
      Value<int> id,
      Value<Subject> subject,
      Value<String> head,
      Value<String> body,
      Value<DateTime> createdAt,
    });

final class $$KnowledgeTableReferences
    extends BaseReferences<_$AppDatabase, $KnowledgeTable, KnowledgeData> {
  $$KnowledgeTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$KnowledgeLogsTable, List<KnowledgeLog>>
  _knowledgeLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.knowledgeLogs,
    aliasName: $_aliasNameGenerator(
      db.knowledge.id,
      db.knowledgeLogs.knowledgeID,
    ),
  );

  $$KnowledgeLogsTableProcessedTableManager get knowledgeLogsRefs {
    final manager = $$KnowledgeLogsTableTableManager(
      $_db,
      $_db.knowledgeLogs,
    ).filter((f) => f.knowledgeID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_knowledgeLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$KnowledgeTagLinkTable, List<KnowledgeTagLinkData>>
  _knowledgeTagLinkRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.knowledgeTagLink,
    aliasName: $_aliasNameGenerator(
      db.knowledge.id,
      db.knowledgeTagLink.knowledgeID,
    ),
  );

  $$KnowledgeTagLinkTableProcessedTableManager get knowledgeTagLinkRefs {
    final manager = $$KnowledgeTagLinkTableTableManager(
      $_db,
      $_db.knowledgeTagLink,
    ).filter((f) => f.knowledgeID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _knowledgeTagLinkRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $QuestionKnowledgeLinkTable,
    List<QuestionKnowledgeLinkData>
  >
  _questionKnowledgeLinkRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.questionKnowledgeLink,
        aliasName: $_aliasNameGenerator(
          db.knowledge.id,
          db.questionKnowledgeLink.knowledgeId,
        ),
      );

  $$QuestionKnowledgeLinkTableProcessedTableManager
  get questionKnowledgeLinkRefs {
    final manager = $$QuestionKnowledgeLinkTableTableManager(
      $_db,
      $_db.questionKnowledgeLink,
    ).filter((f) => f.knowledgeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _questionKnowledgeLinkRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$KnowledgeTableFilterComposer
    extends Composer<_$AppDatabase, $KnowledgeTable> {
  $$KnowledgeTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Subject, Subject, String> get subject =>
      $composableBuilder(
        column: $table.subject,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get head => $composableBuilder(
    column: $table.head,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> knowledgeLogsRefs(
    Expression<bool> Function($$KnowledgeLogsTableFilterComposer f) f,
  ) {
    final $$KnowledgeLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.knowledgeLogs,
      getReferencedColumn: (t) => t.knowledgeID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeLogsTableFilterComposer(
            $db: $db,
            $table: $db.knowledgeLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> knowledgeTagLinkRefs(
    Expression<bool> Function($$KnowledgeTagLinkTableFilterComposer f) f,
  ) {
    final $$KnowledgeTagLinkTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.knowledgeTagLink,
      getReferencedColumn: (t) => t.knowledgeID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeTagLinkTableFilterComposer(
            $db: $db,
            $table: $db.knowledgeTagLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> questionKnowledgeLinkRefs(
    Expression<bool> Function($$QuestionKnowledgeLinkTableFilterComposer f) f,
  ) {
    final $$QuestionKnowledgeLinkTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.questionKnowledgeLink,
          getReferencedColumn: (t) => t.knowledgeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$QuestionKnowledgeLinkTableFilterComposer(
                $db: $db,
                $table: $db.questionKnowledgeLink,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$KnowledgeTableOrderingComposer
    extends Composer<_$AppDatabase, $KnowledgeTable> {
  $$KnowledgeTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get head => $composableBuilder(
    column: $table.head,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KnowledgeTableAnnotationComposer
    extends Composer<_$AppDatabase, $KnowledgeTable> {
  $$KnowledgeTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Subject, String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<String> get head =>
      $composableBuilder(column: $table.head, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> knowledgeLogsRefs<T extends Object>(
    Expression<T> Function($$KnowledgeLogsTableAnnotationComposer a) f,
  ) {
    final $$KnowledgeLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.knowledgeLogs,
      getReferencedColumn: (t) => t.knowledgeID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.knowledgeLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> knowledgeTagLinkRefs<T extends Object>(
    Expression<T> Function($$KnowledgeTagLinkTableAnnotationComposer a) f,
  ) {
    final $$KnowledgeTagLinkTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.knowledgeTagLink,
      getReferencedColumn: (t) => t.knowledgeID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeTagLinkTableAnnotationComposer(
            $db: $db,
            $table: $db.knowledgeTagLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> questionKnowledgeLinkRefs<T extends Object>(
    Expression<T> Function($$QuestionKnowledgeLinkTableAnnotationComposer a) f,
  ) {
    final $$QuestionKnowledgeLinkTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.questionKnowledgeLink,
          getReferencedColumn: (t) => t.knowledgeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$QuestionKnowledgeLinkTableAnnotationComposer(
                $db: $db,
                $table: $db.questionKnowledgeLink,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$KnowledgeTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KnowledgeTable,
          KnowledgeData,
          $$KnowledgeTableFilterComposer,
          $$KnowledgeTableOrderingComposer,
          $$KnowledgeTableAnnotationComposer,
          $$KnowledgeTableCreateCompanionBuilder,
          $$KnowledgeTableUpdateCompanionBuilder,
          (KnowledgeData, $$KnowledgeTableReferences),
          KnowledgeData,
          PrefetchHooks Function({
            bool knowledgeLogsRefs,
            bool knowledgeTagLinkRefs,
            bool questionKnowledgeLinkRefs,
          })
        > {
  $$KnowledgeTableTableManager(_$AppDatabase db, $KnowledgeTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KnowledgeTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KnowledgeTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KnowledgeTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<Subject> subject = const Value.absent(),
                Value<String> head = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => KnowledgeCompanion(
                id: id,
                subject: subject,
                head: head,
                body: body,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required Subject subject,
                required String head,
                required String body,
                Value<DateTime> createdAt = const Value.absent(),
              }) => KnowledgeCompanion.insert(
                id: id,
                subject: subject,
                head: head,
                body: body,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$KnowledgeTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                knowledgeLogsRefs = false,
                knowledgeTagLinkRefs = false,
                questionKnowledgeLinkRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (knowledgeLogsRefs) db.knowledgeLogs,
                    if (knowledgeTagLinkRefs) db.knowledgeTagLink,
                    if (questionKnowledgeLinkRefs) db.questionKnowledgeLink,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (knowledgeLogsRefs)
                        await $_getPrefetchedData<
                          KnowledgeData,
                          $KnowledgeTable,
                          KnowledgeLog
                        >(
                          currentTable: table,
                          referencedTable: $$KnowledgeTableReferences
                              ._knowledgeLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$KnowledgeTableReferences(
                                db,
                                table,
                                p0,
                              ).knowledgeLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.knowledgeID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (knowledgeTagLinkRefs)
                        await $_getPrefetchedData<
                          KnowledgeData,
                          $KnowledgeTable,
                          KnowledgeTagLinkData
                        >(
                          currentTable: table,
                          referencedTable: $$KnowledgeTableReferences
                              ._knowledgeTagLinkRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$KnowledgeTableReferences(
                                db,
                                table,
                                p0,
                              ).knowledgeTagLinkRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.knowledgeID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (questionKnowledgeLinkRefs)
                        await $_getPrefetchedData<
                          KnowledgeData,
                          $KnowledgeTable,
                          QuestionKnowledgeLinkData
                        >(
                          currentTable: table,
                          referencedTable: $$KnowledgeTableReferences
                              ._questionKnowledgeLinkRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$KnowledgeTableReferences(
                                db,
                                table,
                                p0,
                              ).questionKnowledgeLinkRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.knowledgeId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$KnowledgeTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KnowledgeTable,
      KnowledgeData,
      $$KnowledgeTableFilterComposer,
      $$KnowledgeTableOrderingComposer,
      $$KnowledgeTableAnnotationComposer,
      $$KnowledgeTableCreateCompanionBuilder,
      $$KnowledgeTableUpdateCompanionBuilder,
      (KnowledgeData, $$KnowledgeTableReferences),
      KnowledgeData,
      PrefetchHooks Function({
        bool knowledgeLogsRefs,
        bool knowledgeTagLinkRefs,
        bool questionKnowledgeLinkRefs,
      })
    >;
typedef $$KnowledgeLogsTableCreateCompanionBuilder =
    KnowledgeLogsCompanion Function({
      Value<int> id,
      required int knowledgeID,
      Value<DateTime> time,
      required KnowledgeLogType type,
      Value<String?> notes,
    });
typedef $$KnowledgeLogsTableUpdateCompanionBuilder =
    KnowledgeLogsCompanion Function({
      Value<int> id,
      Value<int> knowledgeID,
      Value<DateTime> time,
      Value<KnowledgeLogType> type,
      Value<String?> notes,
    });

final class $$KnowledgeLogsTableReferences
    extends BaseReferences<_$AppDatabase, $KnowledgeLogsTable, KnowledgeLog> {
  $$KnowledgeLogsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $KnowledgeTable _knowledgeIDTable(_$AppDatabase db) =>
      db.knowledge.createAlias(
        $_aliasNameGenerator(db.knowledgeLogs.knowledgeID, db.knowledge.id),
      );

  $$KnowledgeTableProcessedTableManager get knowledgeID {
    final $_column = $_itemColumn<int>('knowledge_i_d')!;

    final manager = $$KnowledgeTableTableManager(
      $_db,
      $_db.knowledge,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_knowledgeIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$KnowledgeLogsTableFilterComposer
    extends Composer<_$AppDatabase, $KnowledgeLogsTable> {
  $$KnowledgeLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<KnowledgeLogType, KnowledgeLogType, String>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$KnowledgeTableFilterComposer get knowledgeID {
    final $$KnowledgeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.knowledgeID,
      referencedTable: $db.knowledge,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeTableFilterComposer(
            $db: $db,
            $table: $db.knowledge,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KnowledgeLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $KnowledgeLogsTable> {
  $$KnowledgeLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$KnowledgeTableOrderingComposer get knowledgeID {
    final $$KnowledgeTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.knowledgeID,
      referencedTable: $db.knowledge,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeTableOrderingComposer(
            $db: $db,
            $table: $db.knowledge,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KnowledgeLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $KnowledgeLogsTable> {
  $$KnowledgeLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumnWithTypeConverter<KnowledgeLogType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$KnowledgeTableAnnotationComposer get knowledgeID {
    final $$KnowledgeTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.knowledgeID,
      referencedTable: $db.knowledge,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeTableAnnotationComposer(
            $db: $db,
            $table: $db.knowledge,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KnowledgeLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KnowledgeLogsTable,
          KnowledgeLog,
          $$KnowledgeLogsTableFilterComposer,
          $$KnowledgeLogsTableOrderingComposer,
          $$KnowledgeLogsTableAnnotationComposer,
          $$KnowledgeLogsTableCreateCompanionBuilder,
          $$KnowledgeLogsTableUpdateCompanionBuilder,
          (KnowledgeLog, $$KnowledgeLogsTableReferences),
          KnowledgeLog,
          PrefetchHooks Function({bool knowledgeID})
        > {
  $$KnowledgeLogsTableTableManager(_$AppDatabase db, $KnowledgeLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KnowledgeLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KnowledgeLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KnowledgeLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> knowledgeID = const Value.absent(),
                Value<DateTime> time = const Value.absent(),
                Value<KnowledgeLogType> type = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => KnowledgeLogsCompanion(
                id: id,
                knowledgeID: knowledgeID,
                time: time,
                type: type,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int knowledgeID,
                Value<DateTime> time = const Value.absent(),
                required KnowledgeLogType type,
                Value<String?> notes = const Value.absent(),
              }) => KnowledgeLogsCompanion.insert(
                id: id,
                knowledgeID: knowledgeID,
                time: time,
                type: type,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$KnowledgeLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({knowledgeID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (knowledgeID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.knowledgeID,
                                referencedTable: $$KnowledgeLogsTableReferences
                                    ._knowledgeIDTable(db),
                                referencedColumn: $$KnowledgeLogsTableReferences
                                    ._knowledgeIDTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$KnowledgeLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KnowledgeLogsTable,
      KnowledgeLog,
      $$KnowledgeLogsTableFilterComposer,
      $$KnowledgeLogsTableOrderingComposer,
      $$KnowledgeLogsTableAnnotationComposer,
      $$KnowledgeLogsTableCreateCompanionBuilder,
      $$KnowledgeLogsTableUpdateCompanionBuilder,
      (KnowledgeLog, $$KnowledgeLogsTableReferences),
      KnowledgeLog,
      PrefetchHooks Function({bool knowledgeID})
    >;
typedef $$KnowledgeTagLinkTableCreateCompanionBuilder =
    KnowledgeTagLinkCompanion Function({
      required int knowledgeID,
      required int tagID,
      Value<int> rowid,
    });
typedef $$KnowledgeTagLinkTableUpdateCompanionBuilder =
    KnowledgeTagLinkCompanion Function({
      Value<int> knowledgeID,
      Value<int> tagID,
      Value<int> rowid,
    });

final class $$KnowledgeTagLinkTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $KnowledgeTagLinkTable,
          KnowledgeTagLinkData
        > {
  $$KnowledgeTagLinkTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $KnowledgeTable _knowledgeIDTable(_$AppDatabase db) =>
      db.knowledge.createAlias(
        $_aliasNameGenerator(db.knowledgeTagLink.knowledgeID, db.knowledge.id),
      );

  $$KnowledgeTableProcessedTableManager get knowledgeID {
    final $_column = $_itemColumn<int>('knowledge_i_d')!;

    final manager = $$KnowledgeTableTableManager(
      $_db,
      $_db.knowledge,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_knowledgeIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTable _tagIDTable(_$AppDatabase db) => db.tags.createAlias(
    $_aliasNameGenerator(db.knowledgeTagLink.tagID, db.tags.id),
  );

  $$TagsTableProcessedTableManager get tagID {
    final $_column = $_itemColumn<int>('tag_i_d')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$KnowledgeTagLinkTableFilterComposer
    extends Composer<_$AppDatabase, $KnowledgeTagLinkTable> {
  $$KnowledgeTagLinkTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$KnowledgeTableFilterComposer get knowledgeID {
    final $$KnowledgeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.knowledgeID,
      referencedTable: $db.knowledge,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeTableFilterComposer(
            $db: $db,
            $table: $db.knowledge,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableFilterComposer get tagID {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KnowledgeTagLinkTableOrderingComposer
    extends Composer<_$AppDatabase, $KnowledgeTagLinkTable> {
  $$KnowledgeTagLinkTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$KnowledgeTableOrderingComposer get knowledgeID {
    final $$KnowledgeTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.knowledgeID,
      referencedTable: $db.knowledge,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeTableOrderingComposer(
            $db: $db,
            $table: $db.knowledge,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableOrderingComposer get tagID {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KnowledgeTagLinkTableAnnotationComposer
    extends Composer<_$AppDatabase, $KnowledgeTagLinkTable> {
  $$KnowledgeTagLinkTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$KnowledgeTableAnnotationComposer get knowledgeID {
    final $$KnowledgeTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.knowledgeID,
      referencedTable: $db.knowledge,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeTableAnnotationComposer(
            $db: $db,
            $table: $db.knowledge,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableAnnotationComposer get tagID {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KnowledgeTagLinkTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KnowledgeTagLinkTable,
          KnowledgeTagLinkData,
          $$KnowledgeTagLinkTableFilterComposer,
          $$KnowledgeTagLinkTableOrderingComposer,
          $$KnowledgeTagLinkTableAnnotationComposer,
          $$KnowledgeTagLinkTableCreateCompanionBuilder,
          $$KnowledgeTagLinkTableUpdateCompanionBuilder,
          (KnowledgeTagLinkData, $$KnowledgeTagLinkTableReferences),
          KnowledgeTagLinkData,
          PrefetchHooks Function({bool knowledgeID, bool tagID})
        > {
  $$KnowledgeTagLinkTableTableManager(
    _$AppDatabase db,
    $KnowledgeTagLinkTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KnowledgeTagLinkTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KnowledgeTagLinkTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KnowledgeTagLinkTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> knowledgeID = const Value.absent(),
                Value<int> tagID = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KnowledgeTagLinkCompanion(
                knowledgeID: knowledgeID,
                tagID: tagID,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int knowledgeID,
                required int tagID,
                Value<int> rowid = const Value.absent(),
              }) => KnowledgeTagLinkCompanion.insert(
                knowledgeID: knowledgeID,
                tagID: tagID,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$KnowledgeTagLinkTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({knowledgeID = false, tagID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (knowledgeID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.knowledgeID,
                                referencedTable:
                                    $$KnowledgeTagLinkTableReferences
                                        ._knowledgeIDTable(db),
                                referencedColumn:
                                    $$KnowledgeTagLinkTableReferences
                                        ._knowledgeIDTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (tagID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tagID,
                                referencedTable:
                                    $$KnowledgeTagLinkTableReferences
                                        ._tagIDTable(db),
                                referencedColumn:
                                    $$KnowledgeTagLinkTableReferences
                                        ._tagIDTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$KnowledgeTagLinkTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KnowledgeTagLinkTable,
      KnowledgeTagLinkData,
      $$KnowledgeTagLinkTableFilterComposer,
      $$KnowledgeTagLinkTableOrderingComposer,
      $$KnowledgeTagLinkTableAnnotationComposer,
      $$KnowledgeTagLinkTableCreateCompanionBuilder,
      $$KnowledgeTagLinkTableUpdateCompanionBuilder,
      (KnowledgeTagLinkData, $$KnowledgeTagLinkTableReferences),
      KnowledgeTagLinkData,
      PrefetchHooks Function({bool knowledgeID, bool tagID})
    >;
typedef $$QuestionsTableCreateCompanionBuilder =
    QuestionsCompanion Function({
      Value<int> id,
      required Subject subject,
      required String questionHeader,
      required String questionBody,
      Value<String?> source,
      Value<DateTime> createdAt,
    });
typedef $$QuestionsTableUpdateCompanionBuilder =
    QuestionsCompanion Function({
      Value<int> id,
      Value<Subject> subject,
      Value<String> questionHeader,
      Value<String> questionBody,
      Value<String?> source,
      Value<DateTime> createdAt,
    });

final class $$QuestionsTableReferences
    extends BaseReferences<_$AppDatabase, $QuestionsTable, Question> {
  $$QuestionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$QuestionsTagLinkTable, List<QuestionsTagLinkData>>
  _questionsTagLinkRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.questionsTagLink,
    aliasName: $_aliasNameGenerator(
      db.questions.id,
      db.questionsTagLink.questionID,
    ),
  );

  $$QuestionsTagLinkTableProcessedTableManager get questionsTagLinkRefs {
    final manager = $$QuestionsTagLinkTableTableManager(
      $_db,
      $_db.questionsTagLink,
    ).filter((f) => f.questionID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _questionsTagLinkRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$QuestionLogsTable, List<QuestionLog>>
  _questionLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.questionLogs,
    aliasName: $_aliasNameGenerator(
      db.questions.id,
      db.questionLogs.questionID,
    ),
  );

  $$QuestionLogsTableProcessedTableManager get questionLogsRefs {
    final manager = $$QuestionLogsTableTableManager(
      $_db,
      $_db.questionLogs,
    ).filter((f) => f.questionID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_questionLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$QuestionPicsLinkTable, List<QuestionPicsLinkData>>
  _questionPicsLinkRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.questionPicsLink,
    aliasName: $_aliasNameGenerator(
      db.questions.id,
      db.questionPicsLink.questionId,
    ),
  );

  $$QuestionPicsLinkTableProcessedTableManager get questionPicsLinkRefs {
    final manager = $$QuestionPicsLinkTableTableManager(
      $_db,
      $_db.questionPicsLink,
    ).filter((f) => f.questionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _questionPicsLinkRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AnswersTable, List<Answer>> _answersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.answers,
    aliasName: $_aliasNameGenerator(db.questions.id, db.answers.questionId),
  );

  $$AnswersTableProcessedTableManager get answersRefs {
    final manager = $$AnswersTableTableManager(
      $_db,
      $_db.answers,
    ).filter((f) => f.questionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_answersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$QuestionAnalysisTable, List<QuestionAnalysi>>
  _questionAnalysisRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.questionAnalysis,
    aliasName: $_aliasNameGenerator(db.questions.id, db.questionAnalysis.id),
  );

  $$QuestionAnalysisTableProcessedTableManager get questionAnalysisRefs {
    final manager = $$QuestionAnalysisTableTableManager(
      $_db,
      $_db.questionAnalysis,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _questionAnalysisRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $QuestionKnowledgeLinkTable,
    List<QuestionKnowledgeLinkData>
  >
  _questionKnowledgeLinkRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.questionKnowledgeLink,
        aliasName: $_aliasNameGenerator(
          db.questions.id,
          db.questionKnowledgeLink.questionId,
        ),
      );

  $$QuestionKnowledgeLinkTableProcessedTableManager
  get questionKnowledgeLinkRefs {
    final manager = $$QuestionKnowledgeLinkTableTableManager(
      $_db,
      $_db.questionKnowledgeLink,
    ).filter((f) => f.questionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _questionKnowledgeLinkRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$QuestionsTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionsTable> {
  $$QuestionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Subject, Subject, String> get subject =>
      $composableBuilder(
        column: $table.subject,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get questionHeader => $composableBuilder(
    column: $table.questionHeader,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionBody => $composableBuilder(
    column: $table.questionBody,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> questionsTagLinkRefs(
    Expression<bool> Function($$QuestionsTagLinkTableFilterComposer f) f,
  ) {
    final $$QuestionsTagLinkTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionsTagLink,
      getReferencedColumn: (t) => t.questionID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTagLinkTableFilterComposer(
            $db: $db,
            $table: $db.questionsTagLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> questionLogsRefs(
    Expression<bool> Function($$QuestionLogsTableFilterComposer f) f,
  ) {
    final $$QuestionLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionLogs,
      getReferencedColumn: (t) => t.questionID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionLogsTableFilterComposer(
            $db: $db,
            $table: $db.questionLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> questionPicsLinkRefs(
    Expression<bool> Function($$QuestionPicsLinkTableFilterComposer f) f,
  ) {
    final $$QuestionPicsLinkTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionPicsLink,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionPicsLinkTableFilterComposer(
            $db: $db,
            $table: $db.questionPicsLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> answersRefs(
    Expression<bool> Function($$AnswersTableFilterComposer f) f,
  ) {
    final $$AnswersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.answers,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnswersTableFilterComposer(
            $db: $db,
            $table: $db.answers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> questionAnalysisRefs(
    Expression<bool> Function($$QuestionAnalysisTableFilterComposer f) f,
  ) {
    final $$QuestionAnalysisTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionAnalysis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionAnalysisTableFilterComposer(
            $db: $db,
            $table: $db.questionAnalysis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> questionKnowledgeLinkRefs(
    Expression<bool> Function($$QuestionKnowledgeLinkTableFilterComposer f) f,
  ) {
    final $$QuestionKnowledgeLinkTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.questionKnowledgeLink,
          getReferencedColumn: (t) => t.questionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$QuestionKnowledgeLinkTableFilterComposer(
                $db: $db,
                $table: $db.questionKnowledgeLink,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$QuestionsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionsTable> {
  $$QuestionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionHeader => $composableBuilder(
    column: $table.questionHeader,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionBody => $composableBuilder(
    column: $table.questionBody,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QuestionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionsTable> {
  $$QuestionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Subject, String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<String> get questionHeader => $composableBuilder(
    column: $table.questionHeader,
    builder: (column) => column,
  );

  GeneratedColumn<String> get questionBody => $composableBuilder(
    column: $table.questionBody,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> questionsTagLinkRefs<T extends Object>(
    Expression<T> Function($$QuestionsTagLinkTableAnnotationComposer a) f,
  ) {
    final $$QuestionsTagLinkTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionsTagLink,
      getReferencedColumn: (t) => t.questionID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTagLinkTableAnnotationComposer(
            $db: $db,
            $table: $db.questionsTagLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> questionLogsRefs<T extends Object>(
    Expression<T> Function($$QuestionLogsTableAnnotationComposer a) f,
  ) {
    final $$QuestionLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionLogs,
      getReferencedColumn: (t) => t.questionID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.questionLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> questionPicsLinkRefs<T extends Object>(
    Expression<T> Function($$QuestionPicsLinkTableAnnotationComposer a) f,
  ) {
    final $$QuestionPicsLinkTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionPicsLink,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionPicsLinkTableAnnotationComposer(
            $db: $db,
            $table: $db.questionPicsLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> answersRefs<T extends Object>(
    Expression<T> Function($$AnswersTableAnnotationComposer a) f,
  ) {
    final $$AnswersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.answers,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnswersTableAnnotationComposer(
            $db: $db,
            $table: $db.answers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> questionAnalysisRefs<T extends Object>(
    Expression<T> Function($$QuestionAnalysisTableAnnotationComposer a) f,
  ) {
    final $$QuestionAnalysisTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionAnalysis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionAnalysisTableAnnotationComposer(
            $db: $db,
            $table: $db.questionAnalysis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> questionKnowledgeLinkRefs<T extends Object>(
    Expression<T> Function($$QuestionKnowledgeLinkTableAnnotationComposer a) f,
  ) {
    final $$QuestionKnowledgeLinkTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.questionKnowledgeLink,
          getReferencedColumn: (t) => t.questionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$QuestionKnowledgeLinkTableAnnotationComposer(
                $db: $db,
                $table: $db.questionKnowledgeLink,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$QuestionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestionsTable,
          Question,
          $$QuestionsTableFilterComposer,
          $$QuestionsTableOrderingComposer,
          $$QuestionsTableAnnotationComposer,
          $$QuestionsTableCreateCompanionBuilder,
          $$QuestionsTableUpdateCompanionBuilder,
          (Question, $$QuestionsTableReferences),
          Question,
          PrefetchHooks Function({
            bool questionsTagLinkRefs,
            bool questionLogsRefs,
            bool questionPicsLinkRefs,
            bool answersRefs,
            bool questionAnalysisRefs,
            bool questionKnowledgeLinkRefs,
          })
        > {
  $$QuestionsTableTableManager(_$AppDatabase db, $QuestionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<Subject> subject = const Value.absent(),
                Value<String> questionHeader = const Value.absent(),
                Value<String> questionBody = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => QuestionsCompanion(
                id: id,
                subject: subject,
                questionHeader: questionHeader,
                questionBody: questionBody,
                source: source,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required Subject subject,
                required String questionHeader,
                required String questionBody,
                Value<String?> source = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => QuestionsCompanion.insert(
                id: id,
                subject: subject,
                questionHeader: questionHeader,
                questionBody: questionBody,
                source: source,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$QuestionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                questionsTagLinkRefs = false,
                questionLogsRefs = false,
                questionPicsLinkRefs = false,
                answersRefs = false,
                questionAnalysisRefs = false,
                questionKnowledgeLinkRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (questionsTagLinkRefs) db.questionsTagLink,
                    if (questionLogsRefs) db.questionLogs,
                    if (questionPicsLinkRefs) db.questionPicsLink,
                    if (answersRefs) db.answers,
                    if (questionAnalysisRefs) db.questionAnalysis,
                    if (questionKnowledgeLinkRefs) db.questionKnowledgeLink,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (questionsTagLinkRefs)
                        await $_getPrefetchedData<
                          Question,
                          $QuestionsTable,
                          QuestionsTagLinkData
                        >(
                          currentTable: table,
                          referencedTable: $$QuestionsTableReferences
                              ._questionsTagLinkRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuestionsTableReferences(
                                db,
                                table,
                                p0,
                              ).questionsTagLinkRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.questionID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (questionLogsRefs)
                        await $_getPrefetchedData<
                          Question,
                          $QuestionsTable,
                          QuestionLog
                        >(
                          currentTable: table,
                          referencedTable: $$QuestionsTableReferences
                              ._questionLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuestionsTableReferences(
                                db,
                                table,
                                p0,
                              ).questionLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.questionID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (questionPicsLinkRefs)
                        await $_getPrefetchedData<
                          Question,
                          $QuestionsTable,
                          QuestionPicsLinkData
                        >(
                          currentTable: table,
                          referencedTable: $$QuestionsTableReferences
                              ._questionPicsLinkRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuestionsTableReferences(
                                db,
                                table,
                                p0,
                              ).questionPicsLinkRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.questionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (answersRefs)
                        await $_getPrefetchedData<
                          Question,
                          $QuestionsTable,
                          Answer
                        >(
                          currentTable: table,
                          referencedTable: $$QuestionsTableReferences
                              ._answersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuestionsTableReferences(
                                db,
                                table,
                                p0,
                              ).answersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.questionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (questionAnalysisRefs)
                        await $_getPrefetchedData<
                          Question,
                          $QuestionsTable,
                          QuestionAnalysi
                        >(
                          currentTable: table,
                          referencedTable: $$QuestionsTableReferences
                              ._questionAnalysisRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuestionsTableReferences(
                                db,
                                table,
                                p0,
                              ).questionAnalysisRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) =>
                                  referencedItems.where((e) => e.id == item.id),
                          typedResults: items,
                        ),
                      if (questionKnowledgeLinkRefs)
                        await $_getPrefetchedData<
                          Question,
                          $QuestionsTable,
                          QuestionKnowledgeLinkData
                        >(
                          currentTable: table,
                          referencedTable: $$QuestionsTableReferences
                              ._questionKnowledgeLinkRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuestionsTableReferences(
                                db,
                                table,
                                p0,
                              ).questionKnowledgeLinkRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.questionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$QuestionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestionsTable,
      Question,
      $$QuestionsTableFilterComposer,
      $$QuestionsTableOrderingComposer,
      $$QuestionsTableAnnotationComposer,
      $$QuestionsTableCreateCompanionBuilder,
      $$QuestionsTableUpdateCompanionBuilder,
      (Question, $$QuestionsTableReferences),
      Question,
      PrefetchHooks Function({
        bool questionsTagLinkRefs,
        bool questionLogsRefs,
        bool questionPicsLinkRefs,
        bool answersRefs,
        bool questionAnalysisRefs,
        bool questionKnowledgeLinkRefs,
      })
    >;
typedef $$QuestionsTagLinkTableCreateCompanionBuilder =
    QuestionsTagLinkCompanion Function({
      required int questionID,
      required int tagID,
      Value<int> rowid,
    });
typedef $$QuestionsTagLinkTableUpdateCompanionBuilder =
    QuestionsTagLinkCompanion Function({
      Value<int> questionID,
      Value<int> tagID,
      Value<int> rowid,
    });

final class $$QuestionsTagLinkTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $QuestionsTagLinkTable,
          QuestionsTagLinkData
        > {
  $$QuestionsTagLinkTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $QuestionsTable _questionIDTable(_$AppDatabase db) =>
      db.questions.createAlias(
        $_aliasNameGenerator(db.questionsTagLink.questionID, db.questions.id),
      );

  $$QuestionsTableProcessedTableManager get questionID {
    final $_column = $_itemColumn<int>('question_i_d')!;

    final manager = $$QuestionsTableTableManager(
      $_db,
      $_db.questions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTable _tagIDTable(_$AppDatabase db) => db.tags.createAlias(
    $_aliasNameGenerator(db.questionsTagLink.tagID, db.tags.id),
  );

  $$TagsTableProcessedTableManager get tagID {
    final $_column = $_itemColumn<int>('tag_i_d')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$QuestionsTagLinkTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionsTagLinkTable> {
  $$QuestionsTagLinkTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$QuestionsTableFilterComposer get questionID {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionID,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableFilterComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableFilterComposer get tagID {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionsTagLinkTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionsTagLinkTable> {
  $$QuestionsTagLinkTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$QuestionsTableOrderingComposer get questionID {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionID,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableOrderingComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableOrderingComposer get tagID {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionsTagLinkTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionsTagLinkTable> {
  $$QuestionsTagLinkTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$QuestionsTableAnnotationComposer get questionID {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionID,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableAnnotationComposer get tagID {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionsTagLinkTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestionsTagLinkTable,
          QuestionsTagLinkData,
          $$QuestionsTagLinkTableFilterComposer,
          $$QuestionsTagLinkTableOrderingComposer,
          $$QuestionsTagLinkTableAnnotationComposer,
          $$QuestionsTagLinkTableCreateCompanionBuilder,
          $$QuestionsTagLinkTableUpdateCompanionBuilder,
          (QuestionsTagLinkData, $$QuestionsTagLinkTableReferences),
          QuestionsTagLinkData,
          PrefetchHooks Function({bool questionID, bool tagID})
        > {
  $$QuestionsTagLinkTableTableManager(
    _$AppDatabase db,
    $QuestionsTagLinkTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionsTagLinkTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionsTagLinkTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionsTagLinkTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> questionID = const Value.absent(),
                Value<int> tagID = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionsTagLinkCompanion(
                questionID: questionID,
                tagID: tagID,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int questionID,
                required int tagID,
                Value<int> rowid = const Value.absent(),
              }) => QuestionsTagLinkCompanion.insert(
                questionID: questionID,
                tagID: tagID,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$QuestionsTagLinkTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({questionID = false, tagID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (questionID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.questionID,
                                referencedTable:
                                    $$QuestionsTagLinkTableReferences
                                        ._questionIDTable(db),
                                referencedColumn:
                                    $$QuestionsTagLinkTableReferences
                                        ._questionIDTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (tagID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tagID,
                                referencedTable:
                                    $$QuestionsTagLinkTableReferences
                                        ._tagIDTable(db),
                                referencedColumn:
                                    $$QuestionsTagLinkTableReferences
                                        ._tagIDTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$QuestionsTagLinkTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestionsTagLinkTable,
      QuestionsTagLinkData,
      $$QuestionsTagLinkTableFilterComposer,
      $$QuestionsTagLinkTableOrderingComposer,
      $$QuestionsTagLinkTableAnnotationComposer,
      $$QuestionsTagLinkTableCreateCompanionBuilder,
      $$QuestionsTagLinkTableUpdateCompanionBuilder,
      (QuestionsTagLinkData, $$QuestionsTagLinkTableReferences),
      QuestionsTagLinkData,
      PrefetchHooks Function({bool questionID, bool tagID})
    >;
typedef $$QuestionLogsTableCreateCompanionBuilder =
    QuestionLogsCompanion Function({
      Value<int> id,
      required int questionID,
      required QuestionLogType type,
      Value<DateTime> timestamp,
      Value<String?> notes,
    });
typedef $$QuestionLogsTableUpdateCompanionBuilder =
    QuestionLogsCompanion Function({
      Value<int> id,
      Value<int> questionID,
      Value<QuestionLogType> type,
      Value<DateTime> timestamp,
      Value<String?> notes,
    });

final class $$QuestionLogsTableReferences
    extends BaseReferences<_$AppDatabase, $QuestionLogsTable, QuestionLog> {
  $$QuestionLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $QuestionsTable _questionIDTable(_$AppDatabase db) =>
      db.questions.createAlias(
        $_aliasNameGenerator(db.questionLogs.questionID, db.questions.id),
      );

  $$QuestionsTableProcessedTableManager get questionID {
    final $_column = $_itemColumn<int>('question_i_d')!;

    final manager = $$QuestionsTableTableManager(
      $_db,
      $_db.questions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$QuestionLogsTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionLogsTable> {
  $$QuestionLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<QuestionLogType, QuestionLogType, String>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$QuestionsTableFilterComposer get questionID {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionID,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableFilterComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionLogsTable> {
  $$QuestionLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuestionsTableOrderingComposer get questionID {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionID,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableOrderingComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionLogsTable> {
  $$QuestionLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<QuestionLogType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$QuestionsTableAnnotationComposer get questionID {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionID,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestionLogsTable,
          QuestionLog,
          $$QuestionLogsTableFilterComposer,
          $$QuestionLogsTableOrderingComposer,
          $$QuestionLogsTableAnnotationComposer,
          $$QuestionLogsTableCreateCompanionBuilder,
          $$QuestionLogsTableUpdateCompanionBuilder,
          (QuestionLog, $$QuestionLogsTableReferences),
          QuestionLog,
          PrefetchHooks Function({bool questionID})
        > {
  $$QuestionLogsTableTableManager(_$AppDatabase db, $QuestionLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> questionID = const Value.absent(),
                Value<QuestionLogType> type = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => QuestionLogsCompanion(
                id: id,
                questionID: questionID,
                type: type,
                timestamp: timestamp,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int questionID,
                required QuestionLogType type,
                Value<DateTime> timestamp = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => QuestionLogsCompanion.insert(
                id: id,
                questionID: questionID,
                type: type,
                timestamp: timestamp,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$QuestionLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({questionID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (questionID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.questionID,
                                referencedTable: $$QuestionLogsTableReferences
                                    ._questionIDTable(db),
                                referencedColumn: $$QuestionLogsTableReferences
                                    ._questionIDTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$QuestionLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestionLogsTable,
      QuestionLog,
      $$QuestionLogsTableFilterComposer,
      $$QuestionLogsTableOrderingComposer,
      $$QuestionLogsTableAnnotationComposer,
      $$QuestionLogsTableCreateCompanionBuilder,
      $$QuestionLogsTableUpdateCompanionBuilder,
      (QuestionLog, $$QuestionLogsTableReferences),
      QuestionLog,
      PrefetchHooks Function({bool questionID})
    >;
typedef $$QuestionPicsLinkTableCreateCompanionBuilder =
    QuestionPicsLinkCompanion Function({
      required int questionId,
      required int picId,
      Value<int> rowid,
    });
typedef $$QuestionPicsLinkTableUpdateCompanionBuilder =
    QuestionPicsLinkCompanion Function({
      Value<int> questionId,
      Value<int> picId,
      Value<int> rowid,
    });

final class $$QuestionPicsLinkTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $QuestionPicsLinkTable,
          QuestionPicsLinkData
        > {
  $$QuestionPicsLinkTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $QuestionsTable _questionIdTable(_$AppDatabase db) =>
      db.questions.createAlias(
        $_aliasNameGenerator(db.questionPicsLink.questionId, db.questions.id),
      );

  $$QuestionsTableProcessedTableManager get questionId {
    final $_column = $_itemColumn<int>('question_id')!;

    final manager = $$QuestionsTableTableManager(
      $_db,
      $_db.questions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ImagesTable _picIdTable(_$AppDatabase db) => db.images.createAlias(
    $_aliasNameGenerator(db.questionPicsLink.picId, db.images.id),
  );

  $$ImagesTableProcessedTableManager get picId {
    final $_column = $_itemColumn<int>('pic_id')!;

    final manager = $$ImagesTableTableManager(
      $_db,
      $_db.images,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_picIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$QuestionPicsLinkTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionPicsLinkTable> {
  $$QuestionPicsLinkTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$QuestionsTableFilterComposer get questionId {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableFilterComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ImagesTableFilterComposer get picId {
    final $$ImagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.picId,
      referencedTable: $db.images,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImagesTableFilterComposer(
            $db: $db,
            $table: $db.images,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionPicsLinkTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionPicsLinkTable> {
  $$QuestionPicsLinkTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$QuestionsTableOrderingComposer get questionId {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableOrderingComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ImagesTableOrderingComposer get picId {
    final $$ImagesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.picId,
      referencedTable: $db.images,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImagesTableOrderingComposer(
            $db: $db,
            $table: $db.images,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionPicsLinkTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionPicsLinkTable> {
  $$QuestionPicsLinkTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$QuestionsTableAnnotationComposer get questionId {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ImagesTableAnnotationComposer get picId {
    final $$ImagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.picId,
      referencedTable: $db.images,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImagesTableAnnotationComposer(
            $db: $db,
            $table: $db.images,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionPicsLinkTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestionPicsLinkTable,
          QuestionPicsLinkData,
          $$QuestionPicsLinkTableFilterComposer,
          $$QuestionPicsLinkTableOrderingComposer,
          $$QuestionPicsLinkTableAnnotationComposer,
          $$QuestionPicsLinkTableCreateCompanionBuilder,
          $$QuestionPicsLinkTableUpdateCompanionBuilder,
          (QuestionPicsLinkData, $$QuestionPicsLinkTableReferences),
          QuestionPicsLinkData,
          PrefetchHooks Function({bool questionId, bool picId})
        > {
  $$QuestionPicsLinkTableTableManager(
    _$AppDatabase db,
    $QuestionPicsLinkTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionPicsLinkTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionPicsLinkTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionPicsLinkTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> questionId = const Value.absent(),
                Value<int> picId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionPicsLinkCompanion(
                questionId: questionId,
                picId: picId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int questionId,
                required int picId,
                Value<int> rowid = const Value.absent(),
              }) => QuestionPicsLinkCompanion.insert(
                questionId: questionId,
                picId: picId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$QuestionPicsLinkTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({questionId = false, picId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (questionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.questionId,
                                referencedTable:
                                    $$QuestionPicsLinkTableReferences
                                        ._questionIdTable(db),
                                referencedColumn:
                                    $$QuestionPicsLinkTableReferences
                                        ._questionIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (picId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.picId,
                                referencedTable:
                                    $$QuestionPicsLinkTableReferences
                                        ._picIdTable(db),
                                referencedColumn:
                                    $$QuestionPicsLinkTableReferences
                                        ._picIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$QuestionPicsLinkTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestionPicsLinkTable,
      QuestionPicsLinkData,
      $$QuestionPicsLinkTableFilterComposer,
      $$QuestionPicsLinkTableOrderingComposer,
      $$QuestionPicsLinkTableAnnotationComposer,
      $$QuestionPicsLinkTableCreateCompanionBuilder,
      $$QuestionPicsLinkTableUpdateCompanionBuilder,
      (QuestionPicsLinkData, $$QuestionPicsLinkTableReferences),
      QuestionPicsLinkData,
      PrefetchHooks Function({bool questionId, bool picId})
    >;
typedef $$AnswersTableCreateCompanionBuilder =
    AnswersCompanion Function({
      Value<int> id,
      required int questionId,
      Value<String?> note,
      Value<String?> head,
      Value<String?> source,
      required String answer,
    });
typedef $$AnswersTableUpdateCompanionBuilder =
    AnswersCompanion Function({
      Value<int> id,
      Value<int> questionId,
      Value<String?> note,
      Value<String?> head,
      Value<String?> source,
      Value<String> answer,
    });

final class $$AnswersTableReferences
    extends BaseReferences<_$AppDatabase, $AnswersTable, Answer> {
  $$AnswersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $QuestionsTable _questionIdTable(_$AppDatabase db) =>
      db.questions.createAlias(
        $_aliasNameGenerator(db.answers.questionId, db.questions.id),
      );

  $$QuestionsTableProcessedTableManager get questionId {
    final $_column = $_itemColumn<int>('question_id')!;

    final manager = $$QuestionsTableTableManager(
      $_db,
      $_db.questions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$AnswersTagsLinkTable, List<AnswersTagsLinkData>>
  _answersTagsLinkRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.answersTagsLink,
    aliasName: $_aliasNameGenerator(db.answers.id, db.answersTagsLink.answerID),
  );

  $$AnswersTagsLinkTableProcessedTableManager get answersTagsLinkRefs {
    final manager = $$AnswersTagsLinkTableTableManager(
      $_db,
      $_db.answersTagsLink,
    ).filter((f) => f.answerID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _answersTagsLinkRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AnswerPicsLinkTable, List<AnswerPicsLinkData>>
  _answerPicsLinkRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.answerPicsLink,
    aliasName: $_aliasNameGenerator(db.answers.id, db.answerPicsLink.answerID),
  );

  $$AnswerPicsLinkTableProcessedTableManager get answerPicsLinkRefs {
    final manager = $$AnswerPicsLinkTableTableManager(
      $_db,
      $_db.answerPicsLink,
    ).filter((f) => f.answerID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_answerPicsLinkRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$QuestionAnalysisTable, List<QuestionAnalysi>>
  _questionAnalysisRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.questionAnalysis,
    aliasName: $_aliasNameGenerator(
      db.answers.id,
      db.questionAnalysis.bestAnswer,
    ),
  );

  $$QuestionAnalysisTableProcessedTableManager get questionAnalysisRefs {
    final manager = $$QuestionAnalysisTableTableManager(
      $_db,
      $_db.questionAnalysis,
    ).filter((f) => f.bestAnswer.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _questionAnalysisRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AnswersTableFilterComposer
    extends Composer<_$AppDatabase, $AnswersTable> {
  $$AnswersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get head => $composableBuilder(
    column: $table.head,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answer => $composableBuilder(
    column: $table.answer,
    builder: (column) => ColumnFilters(column),
  );

  $$QuestionsTableFilterComposer get questionId {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableFilterComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> answersTagsLinkRefs(
    Expression<bool> Function($$AnswersTagsLinkTableFilterComposer f) f,
  ) {
    final $$AnswersTagsLinkTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.answersTagsLink,
      getReferencedColumn: (t) => t.answerID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnswersTagsLinkTableFilterComposer(
            $db: $db,
            $table: $db.answersTagsLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> answerPicsLinkRefs(
    Expression<bool> Function($$AnswerPicsLinkTableFilterComposer f) f,
  ) {
    final $$AnswerPicsLinkTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.answerPicsLink,
      getReferencedColumn: (t) => t.answerID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnswerPicsLinkTableFilterComposer(
            $db: $db,
            $table: $db.answerPicsLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> questionAnalysisRefs(
    Expression<bool> Function($$QuestionAnalysisTableFilterComposer f) f,
  ) {
    final $$QuestionAnalysisTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionAnalysis,
      getReferencedColumn: (t) => t.bestAnswer,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionAnalysisTableFilterComposer(
            $db: $db,
            $table: $db.questionAnalysis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AnswersTableOrderingComposer
    extends Composer<_$AppDatabase, $AnswersTable> {
  $$AnswersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get head => $composableBuilder(
    column: $table.head,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answer => $composableBuilder(
    column: $table.answer,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuestionsTableOrderingComposer get questionId {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableOrderingComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnswersTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnswersTable> {
  $$AnswersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get head =>
      $composableBuilder(column: $table.head, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get answer =>
      $composableBuilder(column: $table.answer, builder: (column) => column);

  $$QuestionsTableAnnotationComposer get questionId {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> answersTagsLinkRefs<T extends Object>(
    Expression<T> Function($$AnswersTagsLinkTableAnnotationComposer a) f,
  ) {
    final $$AnswersTagsLinkTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.answersTagsLink,
      getReferencedColumn: (t) => t.answerID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnswersTagsLinkTableAnnotationComposer(
            $db: $db,
            $table: $db.answersTagsLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> answerPicsLinkRefs<T extends Object>(
    Expression<T> Function($$AnswerPicsLinkTableAnnotationComposer a) f,
  ) {
    final $$AnswerPicsLinkTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.answerPicsLink,
      getReferencedColumn: (t) => t.answerID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnswerPicsLinkTableAnnotationComposer(
            $db: $db,
            $table: $db.answerPicsLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> questionAnalysisRefs<T extends Object>(
    Expression<T> Function($$QuestionAnalysisTableAnnotationComposer a) f,
  ) {
    final $$QuestionAnalysisTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionAnalysis,
      getReferencedColumn: (t) => t.bestAnswer,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionAnalysisTableAnnotationComposer(
            $db: $db,
            $table: $db.questionAnalysis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AnswersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AnswersTable,
          Answer,
          $$AnswersTableFilterComposer,
          $$AnswersTableOrderingComposer,
          $$AnswersTableAnnotationComposer,
          $$AnswersTableCreateCompanionBuilder,
          $$AnswersTableUpdateCompanionBuilder,
          (Answer, $$AnswersTableReferences),
          Answer,
          PrefetchHooks Function({
            bool questionId,
            bool answersTagsLinkRefs,
            bool answerPicsLinkRefs,
            bool questionAnalysisRefs,
          })
        > {
  $$AnswersTableTableManager(_$AppDatabase db, $AnswersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnswersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnswersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnswersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> questionId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> head = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<String> answer = const Value.absent(),
              }) => AnswersCompanion(
                id: id,
                questionId: questionId,
                note: note,
                head: head,
                source: source,
                answer: answer,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int questionId,
                Value<String?> note = const Value.absent(),
                Value<String?> head = const Value.absent(),
                Value<String?> source = const Value.absent(),
                required String answer,
              }) => AnswersCompanion.insert(
                id: id,
                questionId: questionId,
                note: note,
                head: head,
                source: source,
                answer: answer,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AnswersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                questionId = false,
                answersTagsLinkRefs = false,
                answerPicsLinkRefs = false,
                questionAnalysisRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (answersTagsLinkRefs) db.answersTagsLink,
                    if (answerPicsLinkRefs) db.answerPicsLink,
                    if (questionAnalysisRefs) db.questionAnalysis,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (questionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.questionId,
                                    referencedTable: $$AnswersTableReferences
                                        ._questionIdTable(db),
                                    referencedColumn: $$AnswersTableReferences
                                        ._questionIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (answersTagsLinkRefs)
                        await $_getPrefetchedData<
                          Answer,
                          $AnswersTable,
                          AnswersTagsLinkData
                        >(
                          currentTable: table,
                          referencedTable: $$AnswersTableReferences
                              ._answersTagsLinkRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AnswersTableReferences(
                                db,
                                table,
                                p0,
                              ).answersTagsLinkRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.answerID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (answerPicsLinkRefs)
                        await $_getPrefetchedData<
                          Answer,
                          $AnswersTable,
                          AnswerPicsLinkData
                        >(
                          currentTable: table,
                          referencedTable: $$AnswersTableReferences
                              ._answerPicsLinkRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AnswersTableReferences(
                                db,
                                table,
                                p0,
                              ).answerPicsLinkRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.answerID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (questionAnalysisRefs)
                        await $_getPrefetchedData<
                          Answer,
                          $AnswersTable,
                          QuestionAnalysi
                        >(
                          currentTable: table,
                          referencedTable: $$AnswersTableReferences
                              ._questionAnalysisRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AnswersTableReferences(
                                db,
                                table,
                                p0,
                              ).questionAnalysisRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bestAnswer == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AnswersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AnswersTable,
      Answer,
      $$AnswersTableFilterComposer,
      $$AnswersTableOrderingComposer,
      $$AnswersTableAnnotationComposer,
      $$AnswersTableCreateCompanionBuilder,
      $$AnswersTableUpdateCompanionBuilder,
      (Answer, $$AnswersTableReferences),
      Answer,
      PrefetchHooks Function({
        bool questionId,
        bool answersTagsLinkRefs,
        bool answerPicsLinkRefs,
        bool questionAnalysisRefs,
      })
    >;
typedef $$AnswersTagsLinkTableCreateCompanionBuilder =
    AnswersTagsLinkCompanion Function({
      required int answerID,
      required int tagID,
      Value<int> rowid,
    });
typedef $$AnswersTagsLinkTableUpdateCompanionBuilder =
    AnswersTagsLinkCompanion Function({
      Value<int> answerID,
      Value<int> tagID,
      Value<int> rowid,
    });

final class $$AnswersTagsLinkTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $AnswersTagsLinkTable,
          AnswersTagsLinkData
        > {
  $$AnswersTagsLinkTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AnswersTable _answerIDTable(_$AppDatabase db) =>
      db.answers.createAlias(
        $_aliasNameGenerator(db.answersTagsLink.answerID, db.answers.id),
      );

  $$AnswersTableProcessedTableManager get answerID {
    final $_column = $_itemColumn<int>('answer_i_d')!;

    final manager = $$AnswersTableTableManager(
      $_db,
      $_db.answers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_answerIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTable _tagIDTable(_$AppDatabase db) => db.tags.createAlias(
    $_aliasNameGenerator(db.answersTagsLink.tagID, db.tags.id),
  );

  $$TagsTableProcessedTableManager get tagID {
    final $_column = $_itemColumn<int>('tag_i_d')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AnswersTagsLinkTableFilterComposer
    extends Composer<_$AppDatabase, $AnswersTagsLinkTable> {
  $$AnswersTagsLinkTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$AnswersTableFilterComposer get answerID {
    final $$AnswersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.answerID,
      referencedTable: $db.answers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnswersTableFilterComposer(
            $db: $db,
            $table: $db.answers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableFilterComposer get tagID {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnswersTagsLinkTableOrderingComposer
    extends Composer<_$AppDatabase, $AnswersTagsLinkTable> {
  $$AnswersTagsLinkTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$AnswersTableOrderingComposer get answerID {
    final $$AnswersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.answerID,
      referencedTable: $db.answers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnswersTableOrderingComposer(
            $db: $db,
            $table: $db.answers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableOrderingComposer get tagID {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnswersTagsLinkTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnswersTagsLinkTable> {
  $$AnswersTagsLinkTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$AnswersTableAnnotationComposer get answerID {
    final $$AnswersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.answerID,
      referencedTable: $db.answers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnswersTableAnnotationComposer(
            $db: $db,
            $table: $db.answers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableAnnotationComposer get tagID {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnswersTagsLinkTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AnswersTagsLinkTable,
          AnswersTagsLinkData,
          $$AnswersTagsLinkTableFilterComposer,
          $$AnswersTagsLinkTableOrderingComposer,
          $$AnswersTagsLinkTableAnnotationComposer,
          $$AnswersTagsLinkTableCreateCompanionBuilder,
          $$AnswersTagsLinkTableUpdateCompanionBuilder,
          (AnswersTagsLinkData, $$AnswersTagsLinkTableReferences),
          AnswersTagsLinkData,
          PrefetchHooks Function({bool answerID, bool tagID})
        > {
  $$AnswersTagsLinkTableTableManager(
    _$AppDatabase db,
    $AnswersTagsLinkTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnswersTagsLinkTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnswersTagsLinkTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnswersTagsLinkTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> answerID = const Value.absent(),
                Value<int> tagID = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnswersTagsLinkCompanion(
                answerID: answerID,
                tagID: tagID,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int answerID,
                required int tagID,
                Value<int> rowid = const Value.absent(),
              }) => AnswersTagsLinkCompanion.insert(
                answerID: answerID,
                tagID: tagID,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AnswersTagsLinkTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({answerID = false, tagID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (answerID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.answerID,
                                referencedTable:
                                    $$AnswersTagsLinkTableReferences
                                        ._answerIDTable(db),
                                referencedColumn:
                                    $$AnswersTagsLinkTableReferences
                                        ._answerIDTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (tagID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tagID,
                                referencedTable:
                                    $$AnswersTagsLinkTableReferences
                                        ._tagIDTable(db),
                                referencedColumn:
                                    $$AnswersTagsLinkTableReferences
                                        ._tagIDTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AnswersTagsLinkTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AnswersTagsLinkTable,
      AnswersTagsLinkData,
      $$AnswersTagsLinkTableFilterComposer,
      $$AnswersTagsLinkTableOrderingComposer,
      $$AnswersTagsLinkTableAnnotationComposer,
      $$AnswersTagsLinkTableCreateCompanionBuilder,
      $$AnswersTagsLinkTableUpdateCompanionBuilder,
      (AnswersTagsLinkData, $$AnswersTagsLinkTableReferences),
      AnswersTagsLinkData,
      PrefetchHooks Function({bool answerID, bool tagID})
    >;
typedef $$AnswerPicsLinkTableCreateCompanionBuilder =
    AnswerPicsLinkCompanion Function({
      required int answerID,
      required int picID,
      Value<int> rowid,
    });
typedef $$AnswerPicsLinkTableUpdateCompanionBuilder =
    AnswerPicsLinkCompanion Function({
      Value<int> answerID,
      Value<int> picID,
      Value<int> rowid,
    });

final class $$AnswerPicsLinkTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $AnswerPicsLinkTable,
          AnswerPicsLinkData
        > {
  $$AnswerPicsLinkTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AnswersTable _answerIDTable(_$AppDatabase db) =>
      db.answers.createAlias(
        $_aliasNameGenerator(db.answerPicsLink.answerID, db.answers.id),
      );

  $$AnswersTableProcessedTableManager get answerID {
    final $_column = $_itemColumn<int>('answer_i_d')!;

    final manager = $$AnswersTableTableManager(
      $_db,
      $_db.answers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_answerIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ImagesTable _picIDTable(_$AppDatabase db) => db.images.createAlias(
    $_aliasNameGenerator(db.answerPicsLink.picID, db.images.id),
  );

  $$ImagesTableProcessedTableManager get picID {
    final $_column = $_itemColumn<int>('pic_i_d')!;

    final manager = $$ImagesTableTableManager(
      $_db,
      $_db.images,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_picIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AnswerPicsLinkTableFilterComposer
    extends Composer<_$AppDatabase, $AnswerPicsLinkTable> {
  $$AnswerPicsLinkTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$AnswersTableFilterComposer get answerID {
    final $$AnswersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.answerID,
      referencedTable: $db.answers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnswersTableFilterComposer(
            $db: $db,
            $table: $db.answers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ImagesTableFilterComposer get picID {
    final $$ImagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.picID,
      referencedTable: $db.images,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImagesTableFilterComposer(
            $db: $db,
            $table: $db.images,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnswerPicsLinkTableOrderingComposer
    extends Composer<_$AppDatabase, $AnswerPicsLinkTable> {
  $$AnswerPicsLinkTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$AnswersTableOrderingComposer get answerID {
    final $$AnswersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.answerID,
      referencedTable: $db.answers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnswersTableOrderingComposer(
            $db: $db,
            $table: $db.answers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ImagesTableOrderingComposer get picID {
    final $$ImagesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.picID,
      referencedTable: $db.images,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImagesTableOrderingComposer(
            $db: $db,
            $table: $db.images,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnswerPicsLinkTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnswerPicsLinkTable> {
  $$AnswerPicsLinkTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$AnswersTableAnnotationComposer get answerID {
    final $$AnswersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.answerID,
      referencedTable: $db.answers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnswersTableAnnotationComposer(
            $db: $db,
            $table: $db.answers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ImagesTableAnnotationComposer get picID {
    final $$ImagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.picID,
      referencedTable: $db.images,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImagesTableAnnotationComposer(
            $db: $db,
            $table: $db.images,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnswerPicsLinkTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AnswerPicsLinkTable,
          AnswerPicsLinkData,
          $$AnswerPicsLinkTableFilterComposer,
          $$AnswerPicsLinkTableOrderingComposer,
          $$AnswerPicsLinkTableAnnotationComposer,
          $$AnswerPicsLinkTableCreateCompanionBuilder,
          $$AnswerPicsLinkTableUpdateCompanionBuilder,
          (AnswerPicsLinkData, $$AnswerPicsLinkTableReferences),
          AnswerPicsLinkData,
          PrefetchHooks Function({bool answerID, bool picID})
        > {
  $$AnswerPicsLinkTableTableManager(
    _$AppDatabase db,
    $AnswerPicsLinkTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnswerPicsLinkTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnswerPicsLinkTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnswerPicsLinkTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> answerID = const Value.absent(),
                Value<int> picID = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnswerPicsLinkCompanion(
                answerID: answerID,
                picID: picID,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int answerID,
                required int picID,
                Value<int> rowid = const Value.absent(),
              }) => AnswerPicsLinkCompanion.insert(
                answerID: answerID,
                picID: picID,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AnswerPicsLinkTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({answerID = false, picID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (answerID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.answerID,
                                referencedTable: $$AnswerPicsLinkTableReferences
                                    ._answerIDTable(db),
                                referencedColumn:
                                    $$AnswerPicsLinkTableReferences
                                        ._answerIDTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (picID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.picID,
                                referencedTable: $$AnswerPicsLinkTableReferences
                                    ._picIDTable(db),
                                referencedColumn:
                                    $$AnswerPicsLinkTableReferences
                                        ._picIDTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AnswerPicsLinkTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AnswerPicsLinkTable,
      AnswerPicsLinkData,
      $$AnswerPicsLinkTableFilterComposer,
      $$AnswerPicsLinkTableOrderingComposer,
      $$AnswerPicsLinkTableAnnotationComposer,
      $$AnswerPicsLinkTableCreateCompanionBuilder,
      $$AnswerPicsLinkTableUpdateCompanionBuilder,
      (AnswerPicsLinkData, $$AnswerPicsLinkTableReferences),
      AnswerPicsLinkData,
      PrefetchHooks Function({bool answerID, bool picID})
    >;
typedef $$QuestionAnalysisTableCreateCompanionBuilder =
    QuestionAnalysisCompanion Function({
      required int id,
      required int bestAnswer,
      Value<String?> reason,
      Value<String?> analysis,
      Value<int> rowid,
    });
typedef $$QuestionAnalysisTableUpdateCompanionBuilder =
    QuestionAnalysisCompanion Function({
      Value<int> id,
      Value<int> bestAnswer,
      Value<String?> reason,
      Value<String?> analysis,
      Value<int> rowid,
    });

final class $$QuestionAnalysisTableReferences
    extends
        BaseReferences<_$AppDatabase, $QuestionAnalysisTable, QuestionAnalysi> {
  $$QuestionAnalysisTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $QuestionsTable _idTable(_$AppDatabase db) => db.questions.createAlias(
    $_aliasNameGenerator(db.questionAnalysis.id, db.questions.id),
  );

  $$QuestionsTableProcessedTableManager get id {
    final $_column = $_itemColumn<int>('id')!;

    final manager = $$QuestionsTableTableManager(
      $_db,
      $_db.questions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AnswersTable _bestAnswerTable(_$AppDatabase db) =>
      db.answers.createAlias(
        $_aliasNameGenerator(db.questionAnalysis.bestAnswer, db.answers.id),
      );

  $$AnswersTableProcessedTableManager get bestAnswer {
    final $_column = $_itemColumn<int>('best_answer')!;

    final manager = $$AnswersTableTableManager(
      $_db,
      $_db.answers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bestAnswerTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$QuestionAnalysisTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionAnalysisTable> {
  $$QuestionAnalysisTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get analysis => $composableBuilder(
    column: $table.analysis,
    builder: (column) => ColumnFilters(column),
  );

  $$QuestionsTableFilterComposer get id {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableFilterComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AnswersTableFilterComposer get bestAnswer {
    final $$AnswersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bestAnswer,
      referencedTable: $db.answers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnswersTableFilterComposer(
            $db: $db,
            $table: $db.answers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionAnalysisTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionAnalysisTable> {
  $$QuestionAnalysisTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get analysis => $composableBuilder(
    column: $table.analysis,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuestionsTableOrderingComposer get id {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableOrderingComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AnswersTableOrderingComposer get bestAnswer {
    final $$AnswersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bestAnswer,
      referencedTable: $db.answers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnswersTableOrderingComposer(
            $db: $db,
            $table: $db.answers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionAnalysisTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionAnalysisTable> {
  $$QuestionAnalysisTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get analysis =>
      $composableBuilder(column: $table.analysis, builder: (column) => column);

  $$QuestionsTableAnnotationComposer get id {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AnswersTableAnnotationComposer get bestAnswer {
    final $$AnswersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bestAnswer,
      referencedTable: $db.answers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnswersTableAnnotationComposer(
            $db: $db,
            $table: $db.answers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionAnalysisTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestionAnalysisTable,
          QuestionAnalysi,
          $$QuestionAnalysisTableFilterComposer,
          $$QuestionAnalysisTableOrderingComposer,
          $$QuestionAnalysisTableAnnotationComposer,
          $$QuestionAnalysisTableCreateCompanionBuilder,
          $$QuestionAnalysisTableUpdateCompanionBuilder,
          (QuestionAnalysi, $$QuestionAnalysisTableReferences),
          QuestionAnalysi,
          PrefetchHooks Function({bool id, bool bestAnswer})
        > {
  $$QuestionAnalysisTableTableManager(
    _$AppDatabase db,
    $QuestionAnalysisTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionAnalysisTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionAnalysisTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionAnalysisTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bestAnswer = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<String?> analysis = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionAnalysisCompanion(
                id: id,
                bestAnswer: bestAnswer,
                reason: reason,
                analysis: analysis,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int id,
                required int bestAnswer,
                Value<String?> reason = const Value.absent(),
                Value<String?> analysis = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionAnalysisCompanion.insert(
                id: id,
                bestAnswer: bestAnswer,
                reason: reason,
                analysis: analysis,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$QuestionAnalysisTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({id = false, bestAnswer = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (id) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.id,
                                referencedTable:
                                    $$QuestionAnalysisTableReferences._idTable(
                                      db,
                                    ),
                                referencedColumn:
                                    $$QuestionAnalysisTableReferences
                                        ._idTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (bestAnswer) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bestAnswer,
                                referencedTable:
                                    $$QuestionAnalysisTableReferences
                                        ._bestAnswerTable(db),
                                referencedColumn:
                                    $$QuestionAnalysisTableReferences
                                        ._bestAnswerTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$QuestionAnalysisTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestionAnalysisTable,
      QuestionAnalysi,
      $$QuestionAnalysisTableFilterComposer,
      $$QuestionAnalysisTableOrderingComposer,
      $$QuestionAnalysisTableAnnotationComposer,
      $$QuestionAnalysisTableCreateCompanionBuilder,
      $$QuestionAnalysisTableUpdateCompanionBuilder,
      (QuestionAnalysi, $$QuestionAnalysisTableReferences),
      QuestionAnalysi,
      PrefetchHooks Function({bool id, bool bestAnswer})
    >;
typedef $$QuestionKnowledgeLinkTableCreateCompanionBuilder =
    QuestionKnowledgeLinkCompanion Function({
      required int questionId,
      required int knowledgeId,
      Value<int> rowid,
    });
typedef $$QuestionKnowledgeLinkTableUpdateCompanionBuilder =
    QuestionKnowledgeLinkCompanion Function({
      Value<int> questionId,
      Value<int> knowledgeId,
      Value<int> rowid,
    });

final class $$QuestionKnowledgeLinkTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $QuestionKnowledgeLinkTable,
          QuestionKnowledgeLinkData
        > {
  $$QuestionKnowledgeLinkTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $QuestionsTable _questionIdTable(_$AppDatabase db) =>
      db.questions.createAlias(
        $_aliasNameGenerator(
          db.questionKnowledgeLink.questionId,
          db.questions.id,
        ),
      );

  $$QuestionsTableProcessedTableManager get questionId {
    final $_column = $_itemColumn<int>('question_id')!;

    final manager = $$QuestionsTableTableManager(
      $_db,
      $_db.questions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $KnowledgeTable _knowledgeIdTable(_$AppDatabase db) =>
      db.knowledge.createAlias(
        $_aliasNameGenerator(
          db.questionKnowledgeLink.knowledgeId,
          db.knowledge.id,
        ),
      );

  $$KnowledgeTableProcessedTableManager get knowledgeId {
    final $_column = $_itemColumn<int>('knowledge_id')!;

    final manager = $$KnowledgeTableTableManager(
      $_db,
      $_db.knowledge,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_knowledgeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$QuestionKnowledgeLinkTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionKnowledgeLinkTable> {
  $$QuestionKnowledgeLinkTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$QuestionsTableFilterComposer get questionId {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableFilterComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KnowledgeTableFilterComposer get knowledgeId {
    final $$KnowledgeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.knowledgeId,
      referencedTable: $db.knowledge,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeTableFilterComposer(
            $db: $db,
            $table: $db.knowledge,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionKnowledgeLinkTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionKnowledgeLinkTable> {
  $$QuestionKnowledgeLinkTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$QuestionsTableOrderingComposer get questionId {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableOrderingComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KnowledgeTableOrderingComposer get knowledgeId {
    final $$KnowledgeTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.knowledgeId,
      referencedTable: $db.knowledge,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeTableOrderingComposer(
            $db: $db,
            $table: $db.knowledge,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionKnowledgeLinkTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionKnowledgeLinkTable> {
  $$QuestionKnowledgeLinkTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$QuestionsTableAnnotationComposer get questionId {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KnowledgeTableAnnotationComposer get knowledgeId {
    final $$KnowledgeTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.knowledgeId,
      referencedTable: $db.knowledge,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeTableAnnotationComposer(
            $db: $db,
            $table: $db.knowledge,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionKnowledgeLinkTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestionKnowledgeLinkTable,
          QuestionKnowledgeLinkData,
          $$QuestionKnowledgeLinkTableFilterComposer,
          $$QuestionKnowledgeLinkTableOrderingComposer,
          $$QuestionKnowledgeLinkTableAnnotationComposer,
          $$QuestionKnowledgeLinkTableCreateCompanionBuilder,
          $$QuestionKnowledgeLinkTableUpdateCompanionBuilder,
          (QuestionKnowledgeLinkData, $$QuestionKnowledgeLinkTableReferences),
          QuestionKnowledgeLinkData,
          PrefetchHooks Function({bool questionId, bool knowledgeId})
        > {
  $$QuestionKnowledgeLinkTableTableManager(
    _$AppDatabase db,
    $QuestionKnowledgeLinkTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionKnowledgeLinkTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$QuestionKnowledgeLinkTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$QuestionKnowledgeLinkTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> questionId = const Value.absent(),
                Value<int> knowledgeId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionKnowledgeLinkCompanion(
                questionId: questionId,
                knowledgeId: knowledgeId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int questionId,
                required int knowledgeId,
                Value<int> rowid = const Value.absent(),
              }) => QuestionKnowledgeLinkCompanion.insert(
                questionId: questionId,
                knowledgeId: knowledgeId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$QuestionKnowledgeLinkTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({questionId = false, knowledgeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (questionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.questionId,
                                referencedTable:
                                    $$QuestionKnowledgeLinkTableReferences
                                        ._questionIdTable(db),
                                referencedColumn:
                                    $$QuestionKnowledgeLinkTableReferences
                                        ._questionIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (knowledgeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.knowledgeId,
                                referencedTable:
                                    $$QuestionKnowledgeLinkTableReferences
                                        ._knowledgeIdTable(db),
                                referencedColumn:
                                    $$QuestionKnowledgeLinkTableReferences
                                        ._knowledgeIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$QuestionKnowledgeLinkTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestionKnowledgeLinkTable,
      QuestionKnowledgeLinkData,
      $$QuestionKnowledgeLinkTableFilterComposer,
      $$QuestionKnowledgeLinkTableOrderingComposer,
      $$QuestionKnowledgeLinkTableAnnotationComposer,
      $$QuestionKnowledgeLinkTableCreateCompanionBuilder,
      $$QuestionKnowledgeLinkTableUpdateCompanionBuilder,
      (QuestionKnowledgeLinkData, $$QuestionKnowledgeLinkTableReferences),
      QuestionKnowledgeLinkData,
      PrefetchHooks Function({bool questionId, bool knowledgeId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ImagesTableTableManager get images =>
      $$ImagesTableTableManager(_db, _db.images);
  $$AiProvidersTableTableManager get aiProviders =>
      $$AiProvidersTableTableManager(_db, _db.aiProviders);
  $$SessionTableTableManager get session =>
      $$SessionTableTableManager(_db, _db.session);
  $$AiHistoriesTableTableManager get aiHistories =>
      $$AiHistoriesTableTableManager(_db, _db.aiHistories);
  $$PromptsTableTableManager get prompts =>
      $$PromptsTableTableManager(_db, _db.prompts);
  $$AiHistoryImagesLinkTableTableManager get aiHistoryImagesLink =>
      $$AiHistoryImagesLinkTableTableManager(_db, _db.aiHistoryImagesLink);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$WordsTableTableManager get words =>
      $$WordsTableTableManager(_db, _db.words);
  $$WordLogsTableTableManager get wordLogs =>
      $$WordLogsTableTableManager(_db, _db.wordLogs);
  $$WordTagLinkTableTableManager get wordTagLink =>
      $$WordTagLinkTableTableManager(_db, _db.wordTagLink);
  $$PhrasesTableTableManager get phrases =>
      $$PhrasesTableTableManager(_db, _db.phrases);
  $$PhrasesTagLinkTableTableManager get phrasesTagLink =>
      $$PhrasesTagLinkTableTableManager(_db, _db.phrasesTagLink);
  $$PhraseLogsTableTableManager get phraseLogs =>
      $$PhraseLogsTableTableManager(_db, _db.phraseLogs);
  $$KnowledgeTableTableManager get knowledge =>
      $$KnowledgeTableTableManager(_db, _db.knowledge);
  $$KnowledgeLogsTableTableManager get knowledgeLogs =>
      $$KnowledgeLogsTableTableManager(_db, _db.knowledgeLogs);
  $$KnowledgeTagLinkTableTableManager get knowledgeTagLink =>
      $$KnowledgeTagLinkTableTableManager(_db, _db.knowledgeTagLink);
  $$QuestionsTableTableManager get questions =>
      $$QuestionsTableTableManager(_db, _db.questions);
  $$QuestionsTagLinkTableTableManager get questionsTagLink =>
      $$QuestionsTagLinkTableTableManager(_db, _db.questionsTagLink);
  $$QuestionLogsTableTableManager get questionLogs =>
      $$QuestionLogsTableTableManager(_db, _db.questionLogs);
  $$QuestionPicsLinkTableTableManager get questionPicsLink =>
      $$QuestionPicsLinkTableTableManager(_db, _db.questionPicsLink);
  $$AnswersTableTableManager get answers =>
      $$AnswersTableTableManager(_db, _db.answers);
  $$AnswersTagsLinkTableTableManager get answersTagsLink =>
      $$AnswersTagsLinkTableTableManager(_db, _db.answersTagsLink);
  $$AnswerPicsLinkTableTableManager get answerPicsLink =>
      $$AnswerPicsLinkTableTableManager(_db, _db.answerPicsLink);
  $$QuestionAnalysisTableTableManager get questionAnalysis =>
      $$QuestionAnalysisTableTableManager(_db, _db.questionAnalysis);
  $$QuestionKnowledgeLinkTableTableManager get questionKnowledgeLink =>
      $$QuestionKnowledgeLinkTableTableManager(_db, _db.questionKnowledgeLink);
}
