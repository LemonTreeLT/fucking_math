// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
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

class $KnowledgeTableTable extends KnowledgeTable
    with TableInfo<$KnowledgeTableTable, KnowledgeTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KnowledgeTableTable(this.attachedDatabase, [this._alias]);
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
      ).withConverter<Subject>($KnowledgeTableTable.$convertersubject);
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
  static const String $name = 'knowledge_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<KnowledgeTableData> instance, {
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
  KnowledgeTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KnowledgeTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      subject: $KnowledgeTableTable.$convertersubject.fromSql(
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
  $KnowledgeTableTable createAlias(String alias) {
    return $KnowledgeTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Subject, String, String> $convertersubject =
      SubjectConverter;
}

class KnowledgeTableData extends DataClass
    implements Insertable<KnowledgeTableData> {
  final int id;
  final Subject subject;
  final String head;
  final String body;
  final DateTime createdAt;
  const KnowledgeTableData({
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
        $KnowledgeTableTable.$convertersubject.toSql(subject),
      );
    }
    map['head'] = Variable<String>(head);
    map['body'] = Variable<String>(body);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  KnowledgeTableCompanion toCompanion(bool nullToAbsent) {
    return KnowledgeTableCompanion(
      id: Value(id),
      subject: Value(subject),
      head: Value(head),
      body: Value(body),
      createdAt: Value(createdAt),
    );
  }

  factory KnowledgeTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KnowledgeTableData(
      id: serializer.fromJson<int>(json['id']),
      subject: $KnowledgeTableTable.$convertersubject.fromJson(
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
        $KnowledgeTableTable.$convertersubject.toJson(subject),
      ),
      'head': serializer.toJson<String>(head),
      'body': serializer.toJson<String>(body),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  KnowledgeTableData copyWith({
    int? id,
    Subject? subject,
    String? head,
    String? body,
    DateTime? createdAt,
  }) => KnowledgeTableData(
    id: id ?? this.id,
    subject: subject ?? this.subject,
    head: head ?? this.head,
    body: body ?? this.body,
    createdAt: createdAt ?? this.createdAt,
  );
  KnowledgeTableData copyWithCompanion(KnowledgeTableCompanion data) {
    return KnowledgeTableData(
      id: data.id.present ? data.id.value : this.id,
      subject: data.subject.present ? data.subject.value : this.subject,
      head: data.head.present ? data.head.value : this.head,
      body: data.body.present ? data.body.value : this.body,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeTableData(')
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
      (other is KnowledgeTableData &&
          other.id == this.id &&
          other.subject == this.subject &&
          other.head == this.head &&
          other.body == this.body &&
          other.createdAt == this.createdAt);
}

class KnowledgeTableCompanion extends UpdateCompanion<KnowledgeTableData> {
  final Value<int> id;
  final Value<Subject> subject;
  final Value<String> head;
  final Value<String> body;
  final Value<DateTime> createdAt;
  const KnowledgeTableCompanion({
    this.id = const Value.absent(),
    this.subject = const Value.absent(),
    this.head = const Value.absent(),
    this.body = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  KnowledgeTableCompanion.insert({
    this.id = const Value.absent(),
    required Subject subject,
    required String head,
    required String body,
    this.createdAt = const Value.absent(),
  }) : subject = Value(subject),
       head = Value(head),
       body = Value(body);
  static Insertable<KnowledgeTableData> custom({
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

  KnowledgeTableCompanion copyWith({
    Value<int>? id,
    Value<Subject>? subject,
    Value<String>? head,
    Value<String>? body,
    Value<DateTime>? createdAt,
  }) {
    return KnowledgeTableCompanion(
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
        $KnowledgeTableTable.$convertersubject.toSql(subject.value),
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
    return (StringBuffer('KnowledgeTableCompanion(')
          ..write('id: $id, ')
          ..write('subject: $subject, ')
          ..write('head: $head, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $KnowledgeLogTableTable extends KnowledgeLogTable
    with TableInfo<$KnowledgeLogTableTable, KnowledgeLogTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KnowledgeLogTableTable(this.attachedDatabase, [this._alias]);
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
      'REFERENCES knowledge_table (id)',
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
      ).withConverter<KnowledgeLogType>($KnowledgeLogTableTable.$convertertype);
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
  static const String $name = 'knowledge_log_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<KnowledgeLogTableData> instance, {
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
  KnowledgeLogTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KnowledgeLogTableData(
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
      type: $KnowledgeLogTableTable.$convertertype.fromSql(
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
  $KnowledgeLogTableTable createAlias(String alias) {
    return $KnowledgeLogTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<KnowledgeLogType, String, String> $convertertype =
      EnumNameConverter(KnowledgeLogType.values);
}

class KnowledgeLogTableData extends DataClass
    implements Insertable<KnowledgeLogTableData> {
  final int id;
  final int knowledgeID;
  final DateTime time;
  final KnowledgeLogType type;
  final String? notes;
  const KnowledgeLogTableData({
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
        $KnowledgeLogTableTable.$convertertype.toSql(type),
      );
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  KnowledgeLogTableCompanion toCompanion(bool nullToAbsent) {
    return KnowledgeLogTableCompanion(
      id: Value(id),
      knowledgeID: Value(knowledgeID),
      time: Value(time),
      type: Value(type),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory KnowledgeLogTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KnowledgeLogTableData(
      id: serializer.fromJson<int>(json['id']),
      knowledgeID: serializer.fromJson<int>(json['knowledgeID']),
      time: serializer.fromJson<DateTime>(json['time']),
      type: $KnowledgeLogTableTable.$convertertype.fromJson(
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
        $KnowledgeLogTableTable.$convertertype.toJson(type),
      ),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  KnowledgeLogTableData copyWith({
    int? id,
    int? knowledgeID,
    DateTime? time,
    KnowledgeLogType? type,
    Value<String?> notes = const Value.absent(),
  }) => KnowledgeLogTableData(
    id: id ?? this.id,
    knowledgeID: knowledgeID ?? this.knowledgeID,
    time: time ?? this.time,
    type: type ?? this.type,
    notes: notes.present ? notes.value : this.notes,
  );
  KnowledgeLogTableData copyWithCompanion(KnowledgeLogTableCompanion data) {
    return KnowledgeLogTableData(
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
    return (StringBuffer('KnowledgeLogTableData(')
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
      (other is KnowledgeLogTableData &&
          other.id == this.id &&
          other.knowledgeID == this.knowledgeID &&
          other.time == this.time &&
          other.type == this.type &&
          other.notes == this.notes);
}

class KnowledgeLogTableCompanion
    extends UpdateCompanion<KnowledgeLogTableData> {
  final Value<int> id;
  final Value<int> knowledgeID;
  final Value<DateTime> time;
  final Value<KnowledgeLogType> type;
  final Value<String?> notes;
  const KnowledgeLogTableCompanion({
    this.id = const Value.absent(),
    this.knowledgeID = const Value.absent(),
    this.time = const Value.absent(),
    this.type = const Value.absent(),
    this.notes = const Value.absent(),
  });
  KnowledgeLogTableCompanion.insert({
    this.id = const Value.absent(),
    required int knowledgeID,
    this.time = const Value.absent(),
    required KnowledgeLogType type,
    this.notes = const Value.absent(),
  }) : knowledgeID = Value(knowledgeID),
       type = Value(type);
  static Insertable<KnowledgeLogTableData> custom({
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

  KnowledgeLogTableCompanion copyWith({
    Value<int>? id,
    Value<int>? knowledgeID,
    Value<DateTime>? time,
    Value<KnowledgeLogType>? type,
    Value<String?>? notes,
  }) {
    return KnowledgeLogTableCompanion(
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
        $KnowledgeLogTableTable.$convertertype.toSql(type.value),
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeLogTableCompanion(')
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
      'REFERENCES knowledge_table (id)',
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

class $MistakesTable extends Mistakes with TableInfo<$MistakesTable, Mistake> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MistakesTable(this.attachedDatabase, [this._alias]);
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
      ).withConverter<Subject>($MistakesTable.$convertersubject);
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
  static const String $name = 'mistakes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Mistake> instance, {
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
  Mistake map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Mistake(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      subject: $MistakesTable.$convertersubject.fromSql(
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
  $MistakesTable createAlias(String alias) {
    return $MistakesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Subject, String, String> $convertersubject =
      SubjectConverter;
}

class Mistake extends DataClass implements Insertable<Mistake> {
  final int id;
  final Subject subject;
  final String questionHeader;
  final String questionBody;
  final String? source;
  final DateTime createdAt;
  const Mistake({
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
        $MistakesTable.$convertersubject.toSql(subject),
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

  MistakesCompanion toCompanion(bool nullToAbsent) {
    return MistakesCompanion(
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

  factory Mistake.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Mistake(
      id: serializer.fromJson<int>(json['id']),
      subject: $MistakesTable.$convertersubject.fromJson(
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
        $MistakesTable.$convertersubject.toJson(subject),
      ),
      'questionHeader': serializer.toJson<String>(questionHeader),
      'questionBody': serializer.toJson<String>(questionBody),
      'source': serializer.toJson<String?>(source),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Mistake copyWith({
    int? id,
    Subject? subject,
    String? questionHeader,
    String? questionBody,
    Value<String?> source = const Value.absent(),
    DateTime? createdAt,
  }) => Mistake(
    id: id ?? this.id,
    subject: subject ?? this.subject,
    questionHeader: questionHeader ?? this.questionHeader,
    questionBody: questionBody ?? this.questionBody,
    source: source.present ? source.value : this.source,
    createdAt: createdAt ?? this.createdAt,
  );
  Mistake copyWithCompanion(MistakesCompanion data) {
    return Mistake(
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
    return (StringBuffer('Mistake(')
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
      (other is Mistake &&
          other.id == this.id &&
          other.subject == this.subject &&
          other.questionHeader == this.questionHeader &&
          other.questionBody == this.questionBody &&
          other.source == this.source &&
          other.createdAt == this.createdAt);
}

class MistakesCompanion extends UpdateCompanion<Mistake> {
  final Value<int> id;
  final Value<Subject> subject;
  final Value<String> questionHeader;
  final Value<String> questionBody;
  final Value<String?> source;
  final Value<DateTime> createdAt;
  const MistakesCompanion({
    this.id = const Value.absent(),
    this.subject = const Value.absent(),
    this.questionHeader = const Value.absent(),
    this.questionBody = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MistakesCompanion.insert({
    this.id = const Value.absent(),
    required Subject subject,
    required String questionHeader,
    required String questionBody,
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : subject = Value(subject),
       questionHeader = Value(questionHeader),
       questionBody = Value(questionBody);
  static Insertable<Mistake> custom({
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

  MistakesCompanion copyWith({
    Value<int>? id,
    Value<Subject>? subject,
    Value<String>? questionHeader,
    Value<String>? questionBody,
    Value<String?>? source,
    Value<DateTime>? createdAt,
  }) {
    return MistakesCompanion(
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
        $MistakesTable.$convertersubject.toSql(subject.value),
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
    return (StringBuffer('MistakesCompanion(')
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

class $MistakesTagLinkTable extends MistakesTagLink
    with TableInfo<$MistakesTagLinkTable, MistakesTagLinkData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MistakesTagLinkTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _mistakeIDMeta = const VerificationMeta(
    'mistakeID',
  );
  @override
  late final GeneratedColumn<int> mistakeID = GeneratedColumn<int>(
    'mistake_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mistakes (id)',
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
  List<GeneratedColumn> get $columns => [mistakeID, tagID];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mistakes_tag_link';
  @override
  VerificationContext validateIntegrity(
    Insertable<MistakesTagLinkData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('mistake_i_d')) {
      context.handle(
        _mistakeIDMeta,
        mistakeID.isAcceptableOrUnknown(data['mistake_i_d']!, _mistakeIDMeta),
      );
    } else if (isInserting) {
      context.missing(_mistakeIDMeta);
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
  Set<GeneratedColumn> get $primaryKey => {mistakeID, tagID};
  @override
  MistakesTagLinkData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MistakesTagLinkData(
      mistakeID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mistake_i_d'],
      )!,
      tagID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tag_i_d'],
      )!,
    );
  }

  @override
  $MistakesTagLinkTable createAlias(String alias) {
    return $MistakesTagLinkTable(attachedDatabase, alias);
  }
}

class MistakesTagLinkData extends DataClass
    implements Insertable<MistakesTagLinkData> {
  final int mistakeID;
  final int tagID;
  const MistakesTagLinkData({required this.mistakeID, required this.tagID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['mistake_i_d'] = Variable<int>(mistakeID);
    map['tag_i_d'] = Variable<int>(tagID);
    return map;
  }

  MistakesTagLinkCompanion toCompanion(bool nullToAbsent) {
    return MistakesTagLinkCompanion(
      mistakeID: Value(mistakeID),
      tagID: Value(tagID),
    );
  }

  factory MistakesTagLinkData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MistakesTagLinkData(
      mistakeID: serializer.fromJson<int>(json['mistakeID']),
      tagID: serializer.fromJson<int>(json['tagID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'mistakeID': serializer.toJson<int>(mistakeID),
      'tagID': serializer.toJson<int>(tagID),
    };
  }

  MistakesTagLinkData copyWith({int? mistakeID, int? tagID}) =>
      MistakesTagLinkData(
        mistakeID: mistakeID ?? this.mistakeID,
        tagID: tagID ?? this.tagID,
      );
  MistakesTagLinkData copyWithCompanion(MistakesTagLinkCompanion data) {
    return MistakesTagLinkData(
      mistakeID: data.mistakeID.present ? data.mistakeID.value : this.mistakeID,
      tagID: data.tagID.present ? data.tagID.value : this.tagID,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MistakesTagLinkData(')
          ..write('mistakeID: $mistakeID, ')
          ..write('tagID: $tagID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(mistakeID, tagID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MistakesTagLinkData &&
          other.mistakeID == this.mistakeID &&
          other.tagID == this.tagID);
}

class MistakesTagLinkCompanion extends UpdateCompanion<MistakesTagLinkData> {
  final Value<int> mistakeID;
  final Value<int> tagID;
  final Value<int> rowid;
  const MistakesTagLinkCompanion({
    this.mistakeID = const Value.absent(),
    this.tagID = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MistakesTagLinkCompanion.insert({
    required int mistakeID,
    required int tagID,
    this.rowid = const Value.absent(),
  }) : mistakeID = Value(mistakeID),
       tagID = Value(tagID);
  static Insertable<MistakesTagLinkData> custom({
    Expression<int>? mistakeID,
    Expression<int>? tagID,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (mistakeID != null) 'mistake_i_d': mistakeID,
      if (tagID != null) 'tag_i_d': tagID,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MistakesTagLinkCompanion copyWith({
    Value<int>? mistakeID,
    Value<int>? tagID,
    Value<int>? rowid,
  }) {
    return MistakesTagLinkCompanion(
      mistakeID: mistakeID ?? this.mistakeID,
      tagID: tagID ?? this.tagID,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (mistakeID.present) {
      map['mistake_i_d'] = Variable<int>(mistakeID.value);
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
    return (StringBuffer('MistakesTagLinkCompanion(')
          ..write('mistakeID: $mistakeID, ')
          ..write('tagID: $tagID, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MistakeLogsTable extends MistakeLogs
    with TableInfo<$MistakeLogsTable, MistakeLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MistakeLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _mistakeIDMeta = const VerificationMeta(
    'mistakeID',
  );
  @override
  late final GeneratedColumn<int> mistakeID = GeneratedColumn<int>(
    'mistake_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mistakes (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<MistakeLogType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<MistakeLogType>($MistakeLogsTable.$convertertype);
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
  List<GeneratedColumn> get $columns => [id, mistakeID, type, timestamp, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mistake_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<MistakeLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('mistake_i_d')) {
      context.handle(
        _mistakeIDMeta,
        mistakeID.isAcceptableOrUnknown(data['mistake_i_d']!, _mistakeIDMeta),
      );
    } else if (isInserting) {
      context.missing(_mistakeIDMeta);
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
  MistakeLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MistakeLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mistakeID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mistake_i_d'],
      )!,
      type: $MistakeLogsTable.$convertertype.fromSql(
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
  $MistakeLogsTable createAlias(String alias) {
    return $MistakeLogsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MistakeLogType, String, String> $convertertype =
      const EnumNameConverter(MistakeLogType.values);
}

class MistakeLog extends DataClass implements Insertable<MistakeLog> {
  final int id;
  final int mistakeID;
  final MistakeLogType type;
  final DateTime timestamp;
  final String? notes;
  const MistakeLog({
    required this.id,
    required this.mistakeID,
    required this.type,
    required this.timestamp,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['mistake_i_d'] = Variable<int>(mistakeID);
    {
      map['type'] = Variable<String>(
        $MistakeLogsTable.$convertertype.toSql(type),
      );
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  MistakeLogsCompanion toCompanion(bool nullToAbsent) {
    return MistakeLogsCompanion(
      id: Value(id),
      mistakeID: Value(mistakeID),
      type: Value(type),
      timestamp: Value(timestamp),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory MistakeLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MistakeLog(
      id: serializer.fromJson<int>(json['id']),
      mistakeID: serializer.fromJson<int>(json['mistakeID']),
      type: $MistakeLogsTable.$convertertype.fromJson(
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
      'mistakeID': serializer.toJson<int>(mistakeID),
      'type': serializer.toJson<String>(
        $MistakeLogsTable.$convertertype.toJson(type),
      ),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  MistakeLog copyWith({
    int? id,
    int? mistakeID,
    MistakeLogType? type,
    DateTime? timestamp,
    Value<String?> notes = const Value.absent(),
  }) => MistakeLog(
    id: id ?? this.id,
    mistakeID: mistakeID ?? this.mistakeID,
    type: type ?? this.type,
    timestamp: timestamp ?? this.timestamp,
    notes: notes.present ? notes.value : this.notes,
  );
  MistakeLog copyWithCompanion(MistakeLogsCompanion data) {
    return MistakeLog(
      id: data.id.present ? data.id.value : this.id,
      mistakeID: data.mistakeID.present ? data.mistakeID.value : this.mistakeID,
      type: data.type.present ? data.type.value : this.type,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MistakeLog(')
          ..write('id: $id, ')
          ..write('mistakeID: $mistakeID, ')
          ..write('type: $type, ')
          ..write('timestamp: $timestamp, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, mistakeID, type, timestamp, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MistakeLog &&
          other.id == this.id &&
          other.mistakeID == this.mistakeID &&
          other.type == this.type &&
          other.timestamp == this.timestamp &&
          other.notes == this.notes);
}

class MistakeLogsCompanion extends UpdateCompanion<MistakeLog> {
  final Value<int> id;
  final Value<int> mistakeID;
  final Value<MistakeLogType> type;
  final Value<DateTime> timestamp;
  final Value<String?> notes;
  const MistakeLogsCompanion({
    this.id = const Value.absent(),
    this.mistakeID = const Value.absent(),
    this.type = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.notes = const Value.absent(),
  });
  MistakeLogsCompanion.insert({
    this.id = const Value.absent(),
    required int mistakeID,
    required MistakeLogType type,
    this.timestamp = const Value.absent(),
    this.notes = const Value.absent(),
  }) : mistakeID = Value(mistakeID),
       type = Value(type);
  static Insertable<MistakeLog> custom({
    Expression<int>? id,
    Expression<int>? mistakeID,
    Expression<String>? type,
    Expression<DateTime>? timestamp,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mistakeID != null) 'mistake_i_d': mistakeID,
      if (type != null) 'type': type,
      if (timestamp != null) 'timestamp': timestamp,
      if (notes != null) 'notes': notes,
    });
  }

  MistakeLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? mistakeID,
    Value<MistakeLogType>? type,
    Value<DateTime>? timestamp,
    Value<String?>? notes,
  }) {
    return MistakeLogsCompanion(
      id: id ?? this.id,
      mistakeID: mistakeID ?? this.mistakeID,
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
    if (mistakeID.present) {
      map['mistake_i_d'] = Variable<int>(mistakeID.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $MistakeLogsTable.$convertertype.toSql(type.value),
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
    return (StringBuffer('MistakeLogsCompanion(')
          ..write('id: $id, ')
          ..write('mistakeID: $mistakeID, ')
          ..write('type: $type, ')
          ..write('timestamp: $timestamp, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

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

class $MistakePicsLinkTable extends MistakePicsLink
    with TableInfo<$MistakePicsLinkTable, MistakePicsLinkData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MistakePicsLinkTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _mistakeIdMeta = const VerificationMeta(
    'mistakeId',
  );
  @override
  late final GeneratedColumn<int> mistakeId = GeneratedColumn<int>(
    'mistake_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mistakes (id)',
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
  List<GeneratedColumn> get $columns => [mistakeId, picId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mistake_pics_link';
  @override
  VerificationContext validateIntegrity(
    Insertable<MistakePicsLinkData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('mistake_id')) {
      context.handle(
        _mistakeIdMeta,
        mistakeId.isAcceptableOrUnknown(data['mistake_id']!, _mistakeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mistakeIdMeta);
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
  Set<GeneratedColumn> get $primaryKey => {mistakeId, picId};
  @override
  MistakePicsLinkData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MistakePicsLinkData(
      mistakeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mistake_id'],
      )!,
      picId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pic_id'],
      )!,
    );
  }

  @override
  $MistakePicsLinkTable createAlias(String alias) {
    return $MistakePicsLinkTable(attachedDatabase, alias);
  }
}

class MistakePicsLinkData extends DataClass
    implements Insertable<MistakePicsLinkData> {
  final int mistakeId;
  final int picId;
  const MistakePicsLinkData({required this.mistakeId, required this.picId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['mistake_id'] = Variable<int>(mistakeId);
    map['pic_id'] = Variable<int>(picId);
    return map;
  }

  MistakePicsLinkCompanion toCompanion(bool nullToAbsent) {
    return MistakePicsLinkCompanion(
      mistakeId: Value(mistakeId),
      picId: Value(picId),
    );
  }

  factory MistakePicsLinkData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MistakePicsLinkData(
      mistakeId: serializer.fromJson<int>(json['mistakeId']),
      picId: serializer.fromJson<int>(json['picId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'mistakeId': serializer.toJson<int>(mistakeId),
      'picId': serializer.toJson<int>(picId),
    };
  }

  MistakePicsLinkData copyWith({int? mistakeId, int? picId}) =>
      MistakePicsLinkData(
        mistakeId: mistakeId ?? this.mistakeId,
        picId: picId ?? this.picId,
      );
  MistakePicsLinkData copyWithCompanion(MistakePicsLinkCompanion data) {
    return MistakePicsLinkData(
      mistakeId: data.mistakeId.present ? data.mistakeId.value : this.mistakeId,
      picId: data.picId.present ? data.picId.value : this.picId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MistakePicsLinkData(')
          ..write('mistakeId: $mistakeId, ')
          ..write('picId: $picId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(mistakeId, picId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MistakePicsLinkData &&
          other.mistakeId == this.mistakeId &&
          other.picId == this.picId);
}

class MistakePicsLinkCompanion extends UpdateCompanion<MistakePicsLinkData> {
  final Value<int> mistakeId;
  final Value<int> picId;
  final Value<int> rowid;
  const MistakePicsLinkCompanion({
    this.mistakeId = const Value.absent(),
    this.picId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MistakePicsLinkCompanion.insert({
    required int mistakeId,
    required int picId,
    this.rowid = const Value.absent(),
  }) : mistakeId = Value(mistakeId),
       picId = Value(picId);
  static Insertable<MistakePicsLinkData> custom({
    Expression<int>? mistakeId,
    Expression<int>? picId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (mistakeId != null) 'mistake_id': mistakeId,
      if (picId != null) 'pic_id': picId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MistakePicsLinkCompanion copyWith({
    Value<int>? mistakeId,
    Value<int>? picId,
    Value<int>? rowid,
  }) {
    return MistakePicsLinkCompanion(
      mistakeId: mistakeId ?? this.mistakeId,
      picId: picId ?? this.picId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (mistakeId.present) {
      map['mistake_id'] = Variable<int>(mistakeId.value);
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
    return (StringBuffer('MistakePicsLinkCompanion(')
          ..write('mistakeId: $mistakeId, ')
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
  static const VerificationMeta _mistakeIdMeta = const VerificationMeta(
    'mistakeId',
  );
  @override
  late final GeneratedColumn<int> mistakeId = GeneratedColumn<int>(
    'mistake_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mistakes (id)',
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
    mistakeId,
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
    if (data.containsKey('mistake_id')) {
      context.handle(
        _mistakeIdMeta,
        mistakeId.isAcceptableOrUnknown(data['mistake_id']!, _mistakeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mistakeIdMeta);
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
      mistakeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mistake_id'],
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
  final int mistakeId;
  final String? note;
  final String? head;
  final String? source;
  final String answer;
  const Answer({
    required this.id,
    required this.mistakeId,
    this.note,
    this.head,
    this.source,
    required this.answer,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['mistake_id'] = Variable<int>(mistakeId);
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
      mistakeId: Value(mistakeId),
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
      mistakeId: serializer.fromJson<int>(json['mistakeId']),
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
      'mistakeId': serializer.toJson<int>(mistakeId),
      'note': serializer.toJson<String?>(note),
      'head': serializer.toJson<String?>(head),
      'source': serializer.toJson<String?>(source),
      'answer': serializer.toJson<String>(answer),
    };
  }

  Answer copyWith({
    int? id,
    int? mistakeId,
    Value<String?> note = const Value.absent(),
    Value<String?> head = const Value.absent(),
    Value<String?> source = const Value.absent(),
    String? answer,
  }) => Answer(
    id: id ?? this.id,
    mistakeId: mistakeId ?? this.mistakeId,
    note: note.present ? note.value : this.note,
    head: head.present ? head.value : this.head,
    source: source.present ? source.value : this.source,
    answer: answer ?? this.answer,
  );
  Answer copyWithCompanion(AnswersCompanion data) {
    return Answer(
      id: data.id.present ? data.id.value : this.id,
      mistakeId: data.mistakeId.present ? data.mistakeId.value : this.mistakeId,
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
          ..write('mistakeId: $mistakeId, ')
          ..write('note: $note, ')
          ..write('head: $head, ')
          ..write('source: $source, ')
          ..write('answer: $answer')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, mistakeId, note, head, source, answer);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Answer &&
          other.id == this.id &&
          other.mistakeId == this.mistakeId &&
          other.note == this.note &&
          other.head == this.head &&
          other.source == this.source &&
          other.answer == this.answer);
}

class AnswersCompanion extends UpdateCompanion<Answer> {
  final Value<int> id;
  final Value<int> mistakeId;
  final Value<String?> note;
  final Value<String?> head;
  final Value<String?> source;
  final Value<String> answer;
  const AnswersCompanion({
    this.id = const Value.absent(),
    this.mistakeId = const Value.absent(),
    this.note = const Value.absent(),
    this.head = const Value.absent(),
    this.source = const Value.absent(),
    this.answer = const Value.absent(),
  });
  AnswersCompanion.insert({
    this.id = const Value.absent(),
    required int mistakeId,
    this.note = const Value.absent(),
    this.head = const Value.absent(),
    this.source = const Value.absent(),
    required String answer,
  }) : mistakeId = Value(mistakeId),
       answer = Value(answer);
  static Insertable<Answer> custom({
    Expression<int>? id,
    Expression<int>? mistakeId,
    Expression<String>? note,
    Expression<String>? head,
    Expression<String>? source,
    Expression<String>? answer,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mistakeId != null) 'mistake_id': mistakeId,
      if (note != null) 'note': note,
      if (head != null) 'head': head,
      if (source != null) 'source': source,
      if (answer != null) 'answer': answer,
    });
  }

  AnswersCompanion copyWith({
    Value<int>? id,
    Value<int>? mistakeId,
    Value<String?>? note,
    Value<String?>? head,
    Value<String?>? source,
    Value<String>? answer,
  }) {
    return AnswersCompanion(
      id: id ?? this.id,
      mistakeId: mistakeId ?? this.mistakeId,
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
    if (mistakeId.present) {
      map['mistake_id'] = Variable<int>(mistakeId.value);
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
          ..write('mistakeId: $mistakeId, ')
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $WordsTable words = $WordsTable(this);
  late final $WordLogsTable wordLogs = $WordLogsTable(this);
  late final $WordTagLinkTable wordTagLink = $WordTagLinkTable(this);
  late final $PhrasesTable phrases = $PhrasesTable(this);
  late final $PhrasesTagLinkTable phrasesTagLink = $PhrasesTagLinkTable(this);
  late final $PhraseLogsTable phraseLogs = $PhraseLogsTable(this);
  late final $KnowledgeTableTable knowledgeTable = $KnowledgeTableTable(this);
  late final $KnowledgeLogTableTable knowledgeLogTable =
      $KnowledgeLogTableTable(this);
  late final $KnowledgeTagLinkTable knowledgeTagLink = $KnowledgeTagLinkTable(
    this,
  );
  late final $MistakesTable mistakes = $MistakesTable(this);
  late final $MistakesTagLinkTable mistakesTagLink = $MistakesTagLinkTable(
    this,
  );
  late final $MistakeLogsTable mistakeLogs = $MistakeLogsTable(this);
  late final $ImagesTable images = $ImagesTable(this);
  late final $MistakePicsLinkTable mistakePicsLink = $MistakePicsLinkTable(
    this,
  );
  late final $AnswersTable answers = $AnswersTable(this);
  late final $AnswersTagsLinkTable answersTagsLink = $AnswersTagsLinkTable(
    this,
  );
  late final $AnswerPicsLinkTable answerPicsLink = $AnswerPicsLinkTable(this);
  late final TagsDao tagsDao = TagsDao(this as AppDatabase);
  late final WordsDao wordsDao = WordsDao(this as AppDatabase);
  late final KnowledgeDao knowledgeDao = KnowledgeDao(this as AppDatabase);
  late final MistakesDao mistakesDao = MistakesDao(this as AppDatabase);
  late final PhrasesDao phrasesDao = PhrasesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    tags,
    words,
    wordLogs,
    wordTagLink,
    phrases,
    phrasesTagLink,
    phraseLogs,
    knowledgeTable,
    knowledgeLogTable,
    knowledgeTagLink,
    mistakes,
    mistakesTagLink,
    mistakeLogs,
    images,
    mistakePicsLink,
    answers,
    answersTagsLink,
    answerPicsLink,
  ];
}

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

  static MultiTypedResultKey<$MistakesTagLinkTable, List<MistakesTagLinkData>>
  _mistakesTagLinkRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mistakesTagLink,
    aliasName: $_aliasNameGenerator(db.tags.id, db.mistakesTagLink.tagID),
  );

  $$MistakesTagLinkTableProcessedTableManager get mistakesTagLinkRefs {
    final manager = $$MistakesTagLinkTableTableManager(
      $_db,
      $_db.mistakesTagLink,
    ).filter((f) => f.tagID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _mistakesTagLinkRefsTable($_db),
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

  Expression<bool> mistakesTagLinkRefs(
    Expression<bool> Function($$MistakesTagLinkTableFilterComposer f) f,
  ) {
    final $$MistakesTagLinkTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mistakesTagLink,
      getReferencedColumn: (t) => t.tagID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MistakesTagLinkTableFilterComposer(
            $db: $db,
            $table: $db.mistakesTagLink,
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

  Expression<T> mistakesTagLinkRefs<T extends Object>(
    Expression<T> Function($$MistakesTagLinkTableAnnotationComposer a) f,
  ) {
    final $$MistakesTagLinkTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mistakesTagLink,
      getReferencedColumn: (t) => t.tagID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MistakesTagLinkTableAnnotationComposer(
            $db: $db,
            $table: $db.mistakesTagLink,
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
            bool mistakesTagLinkRefs,
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
                mistakesTagLinkRefs = false,
                answersTagsLinkRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (wordTagLinkRefs) db.wordTagLink,
                    if (phrasesTagLinkRefs) db.phrasesTagLink,
                    if (knowledgeTagLinkRefs) db.knowledgeTagLink,
                    if (mistakesTagLinkRefs) db.mistakesTagLink,
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
                      if (mistakesTagLinkRefs)
                        await $_getPrefetchedData<
                          Tag,
                          $TagsTable,
                          MistakesTagLinkData
                        >(
                          currentTable: table,
                          referencedTable: $$TagsTableReferences
                              ._mistakesTagLinkRefsTable(db),
                          managerFromTypedResult: (p0) => $$TagsTableReferences(
                            db,
                            table,
                            p0,
                          ).mistakesTagLinkRefs,
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
        bool mistakesTagLinkRefs,
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
typedef $$KnowledgeTableTableCreateCompanionBuilder =
    KnowledgeTableCompanion Function({
      Value<int> id,
      required Subject subject,
      required String head,
      required String body,
      Value<DateTime> createdAt,
    });
typedef $$KnowledgeTableTableUpdateCompanionBuilder =
    KnowledgeTableCompanion Function({
      Value<int> id,
      Value<Subject> subject,
      Value<String> head,
      Value<String> body,
      Value<DateTime> createdAt,
    });

final class $$KnowledgeTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $KnowledgeTableTable,
          KnowledgeTableData
        > {
  $$KnowledgeTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $KnowledgeLogTableTable,
    List<KnowledgeLogTableData>
  >
  _knowledgeLogTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.knowledgeLogTable,
        aliasName: $_aliasNameGenerator(
          db.knowledgeTable.id,
          db.knowledgeLogTable.knowledgeID,
        ),
      );

  $$KnowledgeLogTableTableProcessedTableManager get knowledgeLogTableRefs {
    final manager = $$KnowledgeLogTableTableTableManager(
      $_db,
      $_db.knowledgeLogTable,
    ).filter((f) => f.knowledgeID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _knowledgeLogTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$KnowledgeTagLinkTable, List<KnowledgeTagLinkData>>
  _knowledgeTagLinkRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.knowledgeTagLink,
    aliasName: $_aliasNameGenerator(
      db.knowledgeTable.id,
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
}

class $$KnowledgeTableTableFilterComposer
    extends Composer<_$AppDatabase, $KnowledgeTableTable> {
  $$KnowledgeTableTableFilterComposer({
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

  Expression<bool> knowledgeLogTableRefs(
    Expression<bool> Function($$KnowledgeLogTableTableFilterComposer f) f,
  ) {
    final $$KnowledgeLogTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.knowledgeLogTable,
      getReferencedColumn: (t) => t.knowledgeID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeLogTableTableFilterComposer(
            $db: $db,
            $table: $db.knowledgeLogTable,
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
}

class $$KnowledgeTableTableOrderingComposer
    extends Composer<_$AppDatabase, $KnowledgeTableTable> {
  $$KnowledgeTableTableOrderingComposer({
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

class $$KnowledgeTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $KnowledgeTableTable> {
  $$KnowledgeTableTableAnnotationComposer({
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

  Expression<T> knowledgeLogTableRefs<T extends Object>(
    Expression<T> Function($$KnowledgeLogTableTableAnnotationComposer a) f,
  ) {
    final $$KnowledgeLogTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.knowledgeLogTable,
          getReferencedColumn: (t) => t.knowledgeID,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$KnowledgeLogTableTableAnnotationComposer(
                $db: $db,
                $table: $db.knowledgeLogTable,
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
}

class $$KnowledgeTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KnowledgeTableTable,
          KnowledgeTableData,
          $$KnowledgeTableTableFilterComposer,
          $$KnowledgeTableTableOrderingComposer,
          $$KnowledgeTableTableAnnotationComposer,
          $$KnowledgeTableTableCreateCompanionBuilder,
          $$KnowledgeTableTableUpdateCompanionBuilder,
          (KnowledgeTableData, $$KnowledgeTableTableReferences),
          KnowledgeTableData,
          PrefetchHooks Function({
            bool knowledgeLogTableRefs,
            bool knowledgeTagLinkRefs,
          })
        > {
  $$KnowledgeTableTableTableManager(
    _$AppDatabase db,
    $KnowledgeTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KnowledgeTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KnowledgeTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KnowledgeTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<Subject> subject = const Value.absent(),
                Value<String> head = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => KnowledgeTableCompanion(
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
              }) => KnowledgeTableCompanion.insert(
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
                  $$KnowledgeTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({knowledgeLogTableRefs = false, knowledgeTagLinkRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (knowledgeLogTableRefs) db.knowledgeLogTable,
                    if (knowledgeTagLinkRefs) db.knowledgeTagLink,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (knowledgeLogTableRefs)
                        await $_getPrefetchedData<
                          KnowledgeTableData,
                          $KnowledgeTableTable,
                          KnowledgeLogTableData
                        >(
                          currentTable: table,
                          referencedTable: $$KnowledgeTableTableReferences
                              ._knowledgeLogTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$KnowledgeTableTableReferences(
                                db,
                                table,
                                p0,
                              ).knowledgeLogTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.knowledgeID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (knowledgeTagLinkRefs)
                        await $_getPrefetchedData<
                          KnowledgeTableData,
                          $KnowledgeTableTable,
                          KnowledgeTagLinkData
                        >(
                          currentTable: table,
                          referencedTable: $$KnowledgeTableTableReferences
                              ._knowledgeTagLinkRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$KnowledgeTableTableReferences(
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
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$KnowledgeTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KnowledgeTableTable,
      KnowledgeTableData,
      $$KnowledgeTableTableFilterComposer,
      $$KnowledgeTableTableOrderingComposer,
      $$KnowledgeTableTableAnnotationComposer,
      $$KnowledgeTableTableCreateCompanionBuilder,
      $$KnowledgeTableTableUpdateCompanionBuilder,
      (KnowledgeTableData, $$KnowledgeTableTableReferences),
      KnowledgeTableData,
      PrefetchHooks Function({
        bool knowledgeLogTableRefs,
        bool knowledgeTagLinkRefs,
      })
    >;
typedef $$KnowledgeLogTableTableCreateCompanionBuilder =
    KnowledgeLogTableCompanion Function({
      Value<int> id,
      required int knowledgeID,
      Value<DateTime> time,
      required KnowledgeLogType type,
      Value<String?> notes,
    });
typedef $$KnowledgeLogTableTableUpdateCompanionBuilder =
    KnowledgeLogTableCompanion Function({
      Value<int> id,
      Value<int> knowledgeID,
      Value<DateTime> time,
      Value<KnowledgeLogType> type,
      Value<String?> notes,
    });

final class $$KnowledgeLogTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $KnowledgeLogTableTable,
          KnowledgeLogTableData
        > {
  $$KnowledgeLogTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $KnowledgeTableTable _knowledgeIDTable(_$AppDatabase db) =>
      db.knowledgeTable.createAlias(
        $_aliasNameGenerator(
          db.knowledgeLogTable.knowledgeID,
          db.knowledgeTable.id,
        ),
      );

  $$KnowledgeTableTableProcessedTableManager get knowledgeID {
    final $_column = $_itemColumn<int>('knowledge_i_d')!;

    final manager = $$KnowledgeTableTableTableManager(
      $_db,
      $_db.knowledgeTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_knowledgeIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$KnowledgeLogTableTableFilterComposer
    extends Composer<_$AppDatabase, $KnowledgeLogTableTable> {
  $$KnowledgeLogTableTableFilterComposer({
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

  $$KnowledgeTableTableFilterComposer get knowledgeID {
    final $$KnowledgeTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.knowledgeID,
      referencedTable: $db.knowledgeTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeTableTableFilterComposer(
            $db: $db,
            $table: $db.knowledgeTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KnowledgeLogTableTableOrderingComposer
    extends Composer<_$AppDatabase, $KnowledgeLogTableTable> {
  $$KnowledgeLogTableTableOrderingComposer({
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

  $$KnowledgeTableTableOrderingComposer get knowledgeID {
    final $$KnowledgeTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.knowledgeID,
      referencedTable: $db.knowledgeTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeTableTableOrderingComposer(
            $db: $db,
            $table: $db.knowledgeTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KnowledgeLogTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $KnowledgeLogTableTable> {
  $$KnowledgeLogTableTableAnnotationComposer({
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

  $$KnowledgeTableTableAnnotationComposer get knowledgeID {
    final $$KnowledgeTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.knowledgeID,
      referencedTable: $db.knowledgeTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeTableTableAnnotationComposer(
            $db: $db,
            $table: $db.knowledgeTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KnowledgeLogTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KnowledgeLogTableTable,
          KnowledgeLogTableData,
          $$KnowledgeLogTableTableFilterComposer,
          $$KnowledgeLogTableTableOrderingComposer,
          $$KnowledgeLogTableTableAnnotationComposer,
          $$KnowledgeLogTableTableCreateCompanionBuilder,
          $$KnowledgeLogTableTableUpdateCompanionBuilder,
          (KnowledgeLogTableData, $$KnowledgeLogTableTableReferences),
          KnowledgeLogTableData,
          PrefetchHooks Function({bool knowledgeID})
        > {
  $$KnowledgeLogTableTableTableManager(
    _$AppDatabase db,
    $KnowledgeLogTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KnowledgeLogTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KnowledgeLogTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KnowledgeLogTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> knowledgeID = const Value.absent(),
                Value<DateTime> time = const Value.absent(),
                Value<KnowledgeLogType> type = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => KnowledgeLogTableCompanion(
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
              }) => KnowledgeLogTableCompanion.insert(
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
                  $$KnowledgeLogTableTableReferences(db, table, e),
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
                                referencedTable:
                                    $$KnowledgeLogTableTableReferences
                                        ._knowledgeIDTable(db),
                                referencedColumn:
                                    $$KnowledgeLogTableTableReferences
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

typedef $$KnowledgeLogTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KnowledgeLogTableTable,
      KnowledgeLogTableData,
      $$KnowledgeLogTableTableFilterComposer,
      $$KnowledgeLogTableTableOrderingComposer,
      $$KnowledgeLogTableTableAnnotationComposer,
      $$KnowledgeLogTableTableCreateCompanionBuilder,
      $$KnowledgeLogTableTableUpdateCompanionBuilder,
      (KnowledgeLogTableData, $$KnowledgeLogTableTableReferences),
      KnowledgeLogTableData,
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

  static $KnowledgeTableTable _knowledgeIDTable(_$AppDatabase db) =>
      db.knowledgeTable.createAlias(
        $_aliasNameGenerator(
          db.knowledgeTagLink.knowledgeID,
          db.knowledgeTable.id,
        ),
      );

  $$KnowledgeTableTableProcessedTableManager get knowledgeID {
    final $_column = $_itemColumn<int>('knowledge_i_d')!;

    final manager = $$KnowledgeTableTableTableManager(
      $_db,
      $_db.knowledgeTable,
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
  $$KnowledgeTableTableFilterComposer get knowledgeID {
    final $$KnowledgeTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.knowledgeID,
      referencedTable: $db.knowledgeTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeTableTableFilterComposer(
            $db: $db,
            $table: $db.knowledgeTable,
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
  $$KnowledgeTableTableOrderingComposer get knowledgeID {
    final $$KnowledgeTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.knowledgeID,
      referencedTable: $db.knowledgeTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeTableTableOrderingComposer(
            $db: $db,
            $table: $db.knowledgeTable,
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
  $$KnowledgeTableTableAnnotationComposer get knowledgeID {
    final $$KnowledgeTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.knowledgeID,
      referencedTable: $db.knowledgeTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeTableTableAnnotationComposer(
            $db: $db,
            $table: $db.knowledgeTable,
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
typedef $$MistakesTableCreateCompanionBuilder =
    MistakesCompanion Function({
      Value<int> id,
      required Subject subject,
      required String questionHeader,
      required String questionBody,
      Value<String?> source,
      Value<DateTime> createdAt,
    });
typedef $$MistakesTableUpdateCompanionBuilder =
    MistakesCompanion Function({
      Value<int> id,
      Value<Subject> subject,
      Value<String> questionHeader,
      Value<String> questionBody,
      Value<String?> source,
      Value<DateTime> createdAt,
    });

final class $$MistakesTableReferences
    extends BaseReferences<_$AppDatabase, $MistakesTable, Mistake> {
  $$MistakesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MistakesTagLinkTable, List<MistakesTagLinkData>>
  _mistakesTagLinkRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mistakesTagLink,
    aliasName: $_aliasNameGenerator(
      db.mistakes.id,
      db.mistakesTagLink.mistakeID,
    ),
  );

  $$MistakesTagLinkTableProcessedTableManager get mistakesTagLinkRefs {
    final manager = $$MistakesTagLinkTableTableManager(
      $_db,
      $_db.mistakesTagLink,
    ).filter((f) => f.mistakeID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _mistakesTagLinkRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MistakeLogsTable, List<MistakeLog>>
  _mistakeLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mistakeLogs,
    aliasName: $_aliasNameGenerator(db.mistakes.id, db.mistakeLogs.mistakeID),
  );

  $$MistakeLogsTableProcessedTableManager get mistakeLogsRefs {
    final manager = $$MistakeLogsTableTableManager(
      $_db,
      $_db.mistakeLogs,
    ).filter((f) => f.mistakeID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mistakeLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MistakePicsLinkTable, List<MistakePicsLinkData>>
  _mistakePicsLinkRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mistakePicsLink,
    aliasName: $_aliasNameGenerator(
      db.mistakes.id,
      db.mistakePicsLink.mistakeId,
    ),
  );

  $$MistakePicsLinkTableProcessedTableManager get mistakePicsLinkRefs {
    final manager = $$MistakePicsLinkTableTableManager(
      $_db,
      $_db.mistakePicsLink,
    ).filter((f) => f.mistakeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _mistakePicsLinkRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AnswersTable, List<Answer>> _answersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.answers,
    aliasName: $_aliasNameGenerator(db.mistakes.id, db.answers.mistakeId),
  );

  $$AnswersTableProcessedTableManager get answersRefs {
    final manager = $$AnswersTableTableManager(
      $_db,
      $_db.answers,
    ).filter((f) => f.mistakeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_answersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MistakesTableFilterComposer
    extends Composer<_$AppDatabase, $MistakesTable> {
  $$MistakesTableFilterComposer({
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

  Expression<bool> mistakesTagLinkRefs(
    Expression<bool> Function($$MistakesTagLinkTableFilterComposer f) f,
  ) {
    final $$MistakesTagLinkTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mistakesTagLink,
      getReferencedColumn: (t) => t.mistakeID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MistakesTagLinkTableFilterComposer(
            $db: $db,
            $table: $db.mistakesTagLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mistakeLogsRefs(
    Expression<bool> Function($$MistakeLogsTableFilterComposer f) f,
  ) {
    final $$MistakeLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mistakeLogs,
      getReferencedColumn: (t) => t.mistakeID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MistakeLogsTableFilterComposer(
            $db: $db,
            $table: $db.mistakeLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mistakePicsLinkRefs(
    Expression<bool> Function($$MistakePicsLinkTableFilterComposer f) f,
  ) {
    final $$MistakePicsLinkTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mistakePicsLink,
      getReferencedColumn: (t) => t.mistakeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MistakePicsLinkTableFilterComposer(
            $db: $db,
            $table: $db.mistakePicsLink,
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
      getReferencedColumn: (t) => t.mistakeId,
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
}

class $$MistakesTableOrderingComposer
    extends Composer<_$AppDatabase, $MistakesTable> {
  $$MistakesTableOrderingComposer({
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

class $$MistakesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MistakesTable> {
  $$MistakesTableAnnotationComposer({
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

  Expression<T> mistakesTagLinkRefs<T extends Object>(
    Expression<T> Function($$MistakesTagLinkTableAnnotationComposer a) f,
  ) {
    final $$MistakesTagLinkTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mistakesTagLink,
      getReferencedColumn: (t) => t.mistakeID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MistakesTagLinkTableAnnotationComposer(
            $db: $db,
            $table: $db.mistakesTagLink,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> mistakeLogsRefs<T extends Object>(
    Expression<T> Function($$MistakeLogsTableAnnotationComposer a) f,
  ) {
    final $$MistakeLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mistakeLogs,
      getReferencedColumn: (t) => t.mistakeID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MistakeLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.mistakeLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> mistakePicsLinkRefs<T extends Object>(
    Expression<T> Function($$MistakePicsLinkTableAnnotationComposer a) f,
  ) {
    final $$MistakePicsLinkTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mistakePicsLink,
      getReferencedColumn: (t) => t.mistakeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MistakePicsLinkTableAnnotationComposer(
            $db: $db,
            $table: $db.mistakePicsLink,
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
      getReferencedColumn: (t) => t.mistakeId,
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
}

class $$MistakesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MistakesTable,
          Mistake,
          $$MistakesTableFilterComposer,
          $$MistakesTableOrderingComposer,
          $$MistakesTableAnnotationComposer,
          $$MistakesTableCreateCompanionBuilder,
          $$MistakesTableUpdateCompanionBuilder,
          (Mistake, $$MistakesTableReferences),
          Mistake,
          PrefetchHooks Function({
            bool mistakesTagLinkRefs,
            bool mistakeLogsRefs,
            bool mistakePicsLinkRefs,
            bool answersRefs,
          })
        > {
  $$MistakesTableTableManager(_$AppDatabase db, $MistakesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MistakesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MistakesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MistakesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<Subject> subject = const Value.absent(),
                Value<String> questionHeader = const Value.absent(),
                Value<String> questionBody = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MistakesCompanion(
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
              }) => MistakesCompanion.insert(
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
                  $$MistakesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                mistakesTagLinkRefs = false,
                mistakeLogsRefs = false,
                mistakePicsLinkRefs = false,
                answersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (mistakesTagLinkRefs) db.mistakesTagLink,
                    if (mistakeLogsRefs) db.mistakeLogs,
                    if (mistakePicsLinkRefs) db.mistakePicsLink,
                    if (answersRefs) db.answers,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (mistakesTagLinkRefs)
                        await $_getPrefetchedData<
                          Mistake,
                          $MistakesTable,
                          MistakesTagLinkData
                        >(
                          currentTable: table,
                          referencedTable: $$MistakesTableReferences
                              ._mistakesTagLinkRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MistakesTableReferences(
                                db,
                                table,
                                p0,
                              ).mistakesTagLinkRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mistakeID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (mistakeLogsRefs)
                        await $_getPrefetchedData<
                          Mistake,
                          $MistakesTable,
                          MistakeLog
                        >(
                          currentTable: table,
                          referencedTable: $$MistakesTableReferences
                              ._mistakeLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MistakesTableReferences(
                                db,
                                table,
                                p0,
                              ).mistakeLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mistakeID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (mistakePicsLinkRefs)
                        await $_getPrefetchedData<
                          Mistake,
                          $MistakesTable,
                          MistakePicsLinkData
                        >(
                          currentTable: table,
                          referencedTable: $$MistakesTableReferences
                              ._mistakePicsLinkRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MistakesTableReferences(
                                db,
                                table,
                                p0,
                              ).mistakePicsLinkRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mistakeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (answersRefs)
                        await $_getPrefetchedData<
                          Mistake,
                          $MistakesTable,
                          Answer
                        >(
                          currentTable: table,
                          referencedTable: $$MistakesTableReferences
                              ._answersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MistakesTableReferences(
                                db,
                                table,
                                p0,
                              ).answersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mistakeId == item.id,
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

typedef $$MistakesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MistakesTable,
      Mistake,
      $$MistakesTableFilterComposer,
      $$MistakesTableOrderingComposer,
      $$MistakesTableAnnotationComposer,
      $$MistakesTableCreateCompanionBuilder,
      $$MistakesTableUpdateCompanionBuilder,
      (Mistake, $$MistakesTableReferences),
      Mistake,
      PrefetchHooks Function({
        bool mistakesTagLinkRefs,
        bool mistakeLogsRefs,
        bool mistakePicsLinkRefs,
        bool answersRefs,
      })
    >;
typedef $$MistakesTagLinkTableCreateCompanionBuilder =
    MistakesTagLinkCompanion Function({
      required int mistakeID,
      required int tagID,
      Value<int> rowid,
    });
typedef $$MistakesTagLinkTableUpdateCompanionBuilder =
    MistakesTagLinkCompanion Function({
      Value<int> mistakeID,
      Value<int> tagID,
      Value<int> rowid,
    });

final class $$MistakesTagLinkTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MistakesTagLinkTable,
          MistakesTagLinkData
        > {
  $$MistakesTagLinkTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MistakesTable _mistakeIDTable(_$AppDatabase db) =>
      db.mistakes.createAlias(
        $_aliasNameGenerator(db.mistakesTagLink.mistakeID, db.mistakes.id),
      );

  $$MistakesTableProcessedTableManager get mistakeID {
    final $_column = $_itemColumn<int>('mistake_i_d')!;

    final manager = $$MistakesTableTableManager(
      $_db,
      $_db.mistakes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mistakeIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTable _tagIDTable(_$AppDatabase db) => db.tags.createAlias(
    $_aliasNameGenerator(db.mistakesTagLink.tagID, db.tags.id),
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

class $$MistakesTagLinkTableFilterComposer
    extends Composer<_$AppDatabase, $MistakesTagLinkTable> {
  $$MistakesTagLinkTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MistakesTableFilterComposer get mistakeID {
    final $$MistakesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mistakeID,
      referencedTable: $db.mistakes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MistakesTableFilterComposer(
            $db: $db,
            $table: $db.mistakes,
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

class $$MistakesTagLinkTableOrderingComposer
    extends Composer<_$AppDatabase, $MistakesTagLinkTable> {
  $$MistakesTagLinkTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MistakesTableOrderingComposer get mistakeID {
    final $$MistakesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mistakeID,
      referencedTable: $db.mistakes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MistakesTableOrderingComposer(
            $db: $db,
            $table: $db.mistakes,
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

class $$MistakesTagLinkTableAnnotationComposer
    extends Composer<_$AppDatabase, $MistakesTagLinkTable> {
  $$MistakesTagLinkTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MistakesTableAnnotationComposer get mistakeID {
    final $$MistakesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mistakeID,
      referencedTable: $db.mistakes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MistakesTableAnnotationComposer(
            $db: $db,
            $table: $db.mistakes,
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

class $$MistakesTagLinkTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MistakesTagLinkTable,
          MistakesTagLinkData,
          $$MistakesTagLinkTableFilterComposer,
          $$MistakesTagLinkTableOrderingComposer,
          $$MistakesTagLinkTableAnnotationComposer,
          $$MistakesTagLinkTableCreateCompanionBuilder,
          $$MistakesTagLinkTableUpdateCompanionBuilder,
          (MistakesTagLinkData, $$MistakesTagLinkTableReferences),
          MistakesTagLinkData,
          PrefetchHooks Function({bool mistakeID, bool tagID})
        > {
  $$MistakesTagLinkTableTableManager(
    _$AppDatabase db,
    $MistakesTagLinkTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MistakesTagLinkTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MistakesTagLinkTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MistakesTagLinkTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> mistakeID = const Value.absent(),
                Value<int> tagID = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MistakesTagLinkCompanion(
                mistakeID: mistakeID,
                tagID: tagID,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int mistakeID,
                required int tagID,
                Value<int> rowid = const Value.absent(),
              }) => MistakesTagLinkCompanion.insert(
                mistakeID: mistakeID,
                tagID: tagID,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MistakesTagLinkTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mistakeID = false, tagID = false}) {
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
                    if (mistakeID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.mistakeID,
                                referencedTable:
                                    $$MistakesTagLinkTableReferences
                                        ._mistakeIDTable(db),
                                referencedColumn:
                                    $$MistakesTagLinkTableReferences
                                        ._mistakeIDTable(db)
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
                                    $$MistakesTagLinkTableReferences
                                        ._tagIDTable(db),
                                referencedColumn:
                                    $$MistakesTagLinkTableReferences
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

typedef $$MistakesTagLinkTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MistakesTagLinkTable,
      MistakesTagLinkData,
      $$MistakesTagLinkTableFilterComposer,
      $$MistakesTagLinkTableOrderingComposer,
      $$MistakesTagLinkTableAnnotationComposer,
      $$MistakesTagLinkTableCreateCompanionBuilder,
      $$MistakesTagLinkTableUpdateCompanionBuilder,
      (MistakesTagLinkData, $$MistakesTagLinkTableReferences),
      MistakesTagLinkData,
      PrefetchHooks Function({bool mistakeID, bool tagID})
    >;
typedef $$MistakeLogsTableCreateCompanionBuilder =
    MistakeLogsCompanion Function({
      Value<int> id,
      required int mistakeID,
      required MistakeLogType type,
      Value<DateTime> timestamp,
      Value<String?> notes,
    });
typedef $$MistakeLogsTableUpdateCompanionBuilder =
    MistakeLogsCompanion Function({
      Value<int> id,
      Value<int> mistakeID,
      Value<MistakeLogType> type,
      Value<DateTime> timestamp,
      Value<String?> notes,
    });

final class $$MistakeLogsTableReferences
    extends BaseReferences<_$AppDatabase, $MistakeLogsTable, MistakeLog> {
  $$MistakeLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MistakesTable _mistakeIDTable(_$AppDatabase db) =>
      db.mistakes.createAlias(
        $_aliasNameGenerator(db.mistakeLogs.mistakeID, db.mistakes.id),
      );

  $$MistakesTableProcessedTableManager get mistakeID {
    final $_column = $_itemColumn<int>('mistake_i_d')!;

    final manager = $$MistakesTableTableManager(
      $_db,
      $_db.mistakes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mistakeIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MistakeLogsTableFilterComposer
    extends Composer<_$AppDatabase, $MistakeLogsTable> {
  $$MistakeLogsTableFilterComposer({
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

  ColumnWithTypeConverterFilters<MistakeLogType, MistakeLogType, String>
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

  $$MistakesTableFilterComposer get mistakeID {
    final $$MistakesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mistakeID,
      referencedTable: $db.mistakes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MistakesTableFilterComposer(
            $db: $db,
            $table: $db.mistakes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MistakeLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $MistakeLogsTable> {
  $$MistakeLogsTableOrderingComposer({
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

  $$MistakesTableOrderingComposer get mistakeID {
    final $$MistakesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mistakeID,
      referencedTable: $db.mistakes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MistakesTableOrderingComposer(
            $db: $db,
            $table: $db.mistakes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MistakeLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MistakeLogsTable> {
  $$MistakeLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MistakeLogType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$MistakesTableAnnotationComposer get mistakeID {
    final $$MistakesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mistakeID,
      referencedTable: $db.mistakes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MistakesTableAnnotationComposer(
            $db: $db,
            $table: $db.mistakes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MistakeLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MistakeLogsTable,
          MistakeLog,
          $$MistakeLogsTableFilterComposer,
          $$MistakeLogsTableOrderingComposer,
          $$MistakeLogsTableAnnotationComposer,
          $$MistakeLogsTableCreateCompanionBuilder,
          $$MistakeLogsTableUpdateCompanionBuilder,
          (MistakeLog, $$MistakeLogsTableReferences),
          MistakeLog,
          PrefetchHooks Function({bool mistakeID})
        > {
  $$MistakeLogsTableTableManager(_$AppDatabase db, $MistakeLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MistakeLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MistakeLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MistakeLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mistakeID = const Value.absent(),
                Value<MistakeLogType> type = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => MistakeLogsCompanion(
                id: id,
                mistakeID: mistakeID,
                type: type,
                timestamp: timestamp,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mistakeID,
                required MistakeLogType type,
                Value<DateTime> timestamp = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => MistakeLogsCompanion.insert(
                id: id,
                mistakeID: mistakeID,
                type: type,
                timestamp: timestamp,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MistakeLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mistakeID = false}) {
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
                    if (mistakeID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.mistakeID,
                                referencedTable: $$MistakeLogsTableReferences
                                    ._mistakeIDTable(db),
                                referencedColumn: $$MistakeLogsTableReferences
                                    ._mistakeIDTable(db)
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

typedef $$MistakeLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MistakeLogsTable,
      MistakeLog,
      $$MistakeLogsTableFilterComposer,
      $$MistakeLogsTableOrderingComposer,
      $$MistakeLogsTableAnnotationComposer,
      $$MistakeLogsTableCreateCompanionBuilder,
      $$MistakeLogsTableUpdateCompanionBuilder,
      (MistakeLog, $$MistakeLogsTableReferences),
      MistakeLog,
      PrefetchHooks Function({bool mistakeID})
    >;
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

  static MultiTypedResultKey<$MistakePicsLinkTable, List<MistakePicsLinkData>>
  _mistakePicsLinkRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mistakePicsLink,
    aliasName: $_aliasNameGenerator(db.images.id, db.mistakePicsLink.picId),
  );

  $$MistakePicsLinkTableProcessedTableManager get mistakePicsLinkRefs {
    final manager = $$MistakePicsLinkTableTableManager(
      $_db,
      $_db.mistakePicsLink,
    ).filter((f) => f.picId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _mistakePicsLinkRefsTable($_db),
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

  Expression<bool> mistakePicsLinkRefs(
    Expression<bool> Function($$MistakePicsLinkTableFilterComposer f) f,
  ) {
    final $$MistakePicsLinkTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mistakePicsLink,
      getReferencedColumn: (t) => t.picId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MistakePicsLinkTableFilterComposer(
            $db: $db,
            $table: $db.mistakePicsLink,
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

  Expression<T> mistakePicsLinkRefs<T extends Object>(
    Expression<T> Function($$MistakePicsLinkTableAnnotationComposer a) f,
  ) {
    final $$MistakePicsLinkTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mistakePicsLink,
      getReferencedColumn: (t) => t.picId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MistakePicsLinkTableAnnotationComposer(
            $db: $db,
            $table: $db.mistakePicsLink,
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
            bool mistakePicsLinkRefs,
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
              ({mistakePicsLinkRefs = false, answerPicsLinkRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (mistakePicsLinkRefs) db.mistakePicsLink,
                    if (answerPicsLinkRefs) db.answerPicsLink,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (mistakePicsLinkRefs)
                        await $_getPrefetchedData<
                          Image,
                          $ImagesTable,
                          MistakePicsLinkData
                        >(
                          currentTable: table,
                          referencedTable: $$ImagesTableReferences
                              ._mistakePicsLinkRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ImagesTableReferences(
                                db,
                                table,
                                p0,
                              ).mistakePicsLinkRefs,
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
        bool mistakePicsLinkRefs,
        bool answerPicsLinkRefs,
      })
    >;
typedef $$MistakePicsLinkTableCreateCompanionBuilder =
    MistakePicsLinkCompanion Function({
      required int mistakeId,
      required int picId,
      Value<int> rowid,
    });
typedef $$MistakePicsLinkTableUpdateCompanionBuilder =
    MistakePicsLinkCompanion Function({
      Value<int> mistakeId,
      Value<int> picId,
      Value<int> rowid,
    });

final class $$MistakePicsLinkTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MistakePicsLinkTable,
          MistakePicsLinkData
        > {
  $$MistakePicsLinkTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MistakesTable _mistakeIdTable(_$AppDatabase db) =>
      db.mistakes.createAlias(
        $_aliasNameGenerator(db.mistakePicsLink.mistakeId, db.mistakes.id),
      );

  $$MistakesTableProcessedTableManager get mistakeId {
    final $_column = $_itemColumn<int>('mistake_id')!;

    final manager = $$MistakesTableTableManager(
      $_db,
      $_db.mistakes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mistakeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ImagesTable _picIdTable(_$AppDatabase db) => db.images.createAlias(
    $_aliasNameGenerator(db.mistakePicsLink.picId, db.images.id),
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

class $$MistakePicsLinkTableFilterComposer
    extends Composer<_$AppDatabase, $MistakePicsLinkTable> {
  $$MistakePicsLinkTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MistakesTableFilterComposer get mistakeId {
    final $$MistakesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mistakeId,
      referencedTable: $db.mistakes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MistakesTableFilterComposer(
            $db: $db,
            $table: $db.mistakes,
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

class $$MistakePicsLinkTableOrderingComposer
    extends Composer<_$AppDatabase, $MistakePicsLinkTable> {
  $$MistakePicsLinkTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MistakesTableOrderingComposer get mistakeId {
    final $$MistakesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mistakeId,
      referencedTable: $db.mistakes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MistakesTableOrderingComposer(
            $db: $db,
            $table: $db.mistakes,
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

class $$MistakePicsLinkTableAnnotationComposer
    extends Composer<_$AppDatabase, $MistakePicsLinkTable> {
  $$MistakePicsLinkTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MistakesTableAnnotationComposer get mistakeId {
    final $$MistakesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mistakeId,
      referencedTable: $db.mistakes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MistakesTableAnnotationComposer(
            $db: $db,
            $table: $db.mistakes,
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

class $$MistakePicsLinkTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MistakePicsLinkTable,
          MistakePicsLinkData,
          $$MistakePicsLinkTableFilterComposer,
          $$MistakePicsLinkTableOrderingComposer,
          $$MistakePicsLinkTableAnnotationComposer,
          $$MistakePicsLinkTableCreateCompanionBuilder,
          $$MistakePicsLinkTableUpdateCompanionBuilder,
          (MistakePicsLinkData, $$MistakePicsLinkTableReferences),
          MistakePicsLinkData,
          PrefetchHooks Function({bool mistakeId, bool picId})
        > {
  $$MistakePicsLinkTableTableManager(
    _$AppDatabase db,
    $MistakePicsLinkTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MistakePicsLinkTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MistakePicsLinkTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MistakePicsLinkTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> mistakeId = const Value.absent(),
                Value<int> picId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MistakePicsLinkCompanion(
                mistakeId: mistakeId,
                picId: picId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int mistakeId,
                required int picId,
                Value<int> rowid = const Value.absent(),
              }) => MistakePicsLinkCompanion.insert(
                mistakeId: mistakeId,
                picId: picId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MistakePicsLinkTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mistakeId = false, picId = false}) {
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
                    if (mistakeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.mistakeId,
                                referencedTable:
                                    $$MistakePicsLinkTableReferences
                                        ._mistakeIdTable(db),
                                referencedColumn:
                                    $$MistakePicsLinkTableReferences
                                        ._mistakeIdTable(db)
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
                                    $$MistakePicsLinkTableReferences
                                        ._picIdTable(db),
                                referencedColumn:
                                    $$MistakePicsLinkTableReferences
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

typedef $$MistakePicsLinkTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MistakePicsLinkTable,
      MistakePicsLinkData,
      $$MistakePicsLinkTableFilterComposer,
      $$MistakePicsLinkTableOrderingComposer,
      $$MistakePicsLinkTableAnnotationComposer,
      $$MistakePicsLinkTableCreateCompanionBuilder,
      $$MistakePicsLinkTableUpdateCompanionBuilder,
      (MistakePicsLinkData, $$MistakePicsLinkTableReferences),
      MistakePicsLinkData,
      PrefetchHooks Function({bool mistakeId, bool picId})
    >;
typedef $$AnswersTableCreateCompanionBuilder =
    AnswersCompanion Function({
      Value<int> id,
      required int mistakeId,
      Value<String?> note,
      Value<String?> head,
      Value<String?> source,
      required String answer,
    });
typedef $$AnswersTableUpdateCompanionBuilder =
    AnswersCompanion Function({
      Value<int> id,
      Value<int> mistakeId,
      Value<String?> note,
      Value<String?> head,
      Value<String?> source,
      Value<String> answer,
    });

final class $$AnswersTableReferences
    extends BaseReferences<_$AppDatabase, $AnswersTable, Answer> {
  $$AnswersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MistakesTable _mistakeIdTable(_$AppDatabase db) => db.mistakes
      .createAlias($_aliasNameGenerator(db.answers.mistakeId, db.mistakes.id));

  $$MistakesTableProcessedTableManager get mistakeId {
    final $_column = $_itemColumn<int>('mistake_id')!;

    final manager = $$MistakesTableTableManager(
      $_db,
      $_db.mistakes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mistakeIdTable($_db));
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

  $$MistakesTableFilterComposer get mistakeId {
    final $$MistakesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mistakeId,
      referencedTable: $db.mistakes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MistakesTableFilterComposer(
            $db: $db,
            $table: $db.mistakes,
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

  $$MistakesTableOrderingComposer get mistakeId {
    final $$MistakesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mistakeId,
      referencedTable: $db.mistakes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MistakesTableOrderingComposer(
            $db: $db,
            $table: $db.mistakes,
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

  $$MistakesTableAnnotationComposer get mistakeId {
    final $$MistakesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mistakeId,
      referencedTable: $db.mistakes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MistakesTableAnnotationComposer(
            $db: $db,
            $table: $db.mistakes,
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
            bool mistakeId,
            bool answersTagsLinkRefs,
            bool answerPicsLinkRefs,
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
                Value<int> mistakeId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> head = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<String> answer = const Value.absent(),
              }) => AnswersCompanion(
                id: id,
                mistakeId: mistakeId,
                note: note,
                head: head,
                source: source,
                answer: answer,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mistakeId,
                Value<String?> note = const Value.absent(),
                Value<String?> head = const Value.absent(),
                Value<String?> source = const Value.absent(),
                required String answer,
              }) => AnswersCompanion.insert(
                id: id,
                mistakeId: mistakeId,
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
                mistakeId = false,
                answersTagsLinkRefs = false,
                answerPicsLinkRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (answersTagsLinkRefs) db.answersTagsLink,
                    if (answerPicsLinkRefs) db.answerPicsLink,
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
                        if (mistakeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.mistakeId,
                                    referencedTable: $$AnswersTableReferences
                                        ._mistakeIdTable(db),
                                    referencedColumn: $$AnswersTableReferences
                                        ._mistakeIdTable(db)
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
        bool mistakeId,
        bool answersTagsLinkRefs,
        bool answerPicsLinkRefs,
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
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
  $$KnowledgeTableTableTableManager get knowledgeTable =>
      $$KnowledgeTableTableTableManager(_db, _db.knowledgeTable);
  $$KnowledgeLogTableTableTableManager get knowledgeLogTable =>
      $$KnowledgeLogTableTableTableManager(_db, _db.knowledgeLogTable);
  $$KnowledgeTagLinkTableTableManager get knowledgeTagLink =>
      $$KnowledgeTagLinkTableTableManager(_db, _db.knowledgeTagLink);
  $$MistakesTableTableManager get mistakes =>
      $$MistakesTableTableManager(_db, _db.mistakes);
  $$MistakesTagLinkTableTableManager get mistakesTagLink =>
      $$MistakesTagLinkTableTableManager(_db, _db.mistakesTagLink);
  $$MistakeLogsTableTableManager get mistakeLogs =>
      $$MistakeLogsTableTableManager(_db, _db.mistakeLogs);
  $$ImagesTableTableManager get images =>
      $$ImagesTableTableManager(_db, _db.images);
  $$MistakePicsLinkTableTableManager get mistakePicsLink =>
      $$MistakePicsLinkTableTableManager(_db, _db.mistakePicsLink);
  $$AnswersTableTableManager get answers =>
      $$AnswersTableTableManager(_db, _db.answers);
  $$AnswersTagsLinkTableTableManager get answersTagsLink =>
      $$AnswersTagsLinkTableTableManager(_db, _db.answersTagsLink);
  $$AnswerPicsLinkTableTableManager get answerPicsLink =>
      $$AnswerPicsLinkTableTableManager(_db, _db.answerPicsLink);
}
