// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
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
  List<GeneratedColumn> get $columns => [id, word, definition, createdAt];
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
  final String? definition;
  final DateTime createdAt;
  const Word({
    required this.id,
    required this.word,
    this.definition,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word'] = Variable<String>(word);
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
      'definition': serializer.toJson<String?>(definition),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Word copyWith({
    int? id,
    String? word,
    Value<String?> definition = const Value.absent(),
    DateTime? createdAt,
  }) => Word(
    id: id ?? this.id,
    word: word ?? this.word,
    definition: definition.present ? definition.value : this.definition,
    createdAt: createdAt ?? this.createdAt,
  );
  Word copyWithCompanion(WordsCompanion data) {
    return Word(
      id: data.id.present ? data.id.value : this.id,
      word: data.word.present ? data.word.value : this.word,
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
          ..write('definition: $definition, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, word, definition, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Word &&
          other.id == this.id &&
          other.word == this.word &&
          other.definition == this.definition &&
          other.createdAt == this.createdAt);
}

class WordsCompanion extends UpdateCompanion<Word> {
  final Value<int> id;
  final Value<String> word;
  final Value<String?> definition;
  final Value<DateTime> createdAt;
  const WordsCompanion({
    this.id = const Value.absent(),
    this.word = const Value.absent(),
    this.definition = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  WordsCompanion.insert({
    this.id = const Value.absent(),
    required String word,
    this.definition = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : word = Value(word);
  static Insertable<Word> custom({
    Expression<int>? id,
    Expression<String>? word,
    Expression<String>? definition,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (word != null) 'word': word,
      if (definition != null) 'definition': definition,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  WordsCompanion copyWith({
    Value<int>? id,
    Value<String>? word,
    Value<String?>? definition,
    Value<DateTime>? createdAt,
  }) {
    return WordsCompanion(
      id: id ?? this.id,
      word: word ?? this.word,
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
  late final GeneratedColumnWithTypeConverter<LogType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LogType>($WordLogsTable.$convertertype);
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

  static TypeConverter<LogType, String> $convertertype =
      const LogTypeConverter();
}

class WordLog extends DataClass implements Insertable<WordLog> {
  final int id;
  final int wordID;
  final LogType type;
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
      type: serializer.fromJson<LogType>(json['type']),
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
      'type': serializer.toJson<LogType>(type),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  WordLog copyWith({
    int? id,
    int? wordID,
    LogType? type,
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
  final Value<LogType> type;
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
    required LogType type,
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
    Value<LogType>? type,
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
  static const VerificationMeta _correctAnswerMeta = const VerificationMeta(
    'correctAnswer',
  );
  @override
  late final GeneratedColumn<String> correctAnswer = GeneratedColumn<String>(
    'correct_answer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unvifiedAnswerMeta = const VerificationMeta(
    'unvifiedAnswer',
  );
  @override
  late final GeneratedColumn<String> unvifiedAnswer = GeneratedColumn<String>(
    'unvified_answer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userAnswerMeta = const VerificationMeta(
    'userAnswer',
  );
  @override
  late final GeneratedColumn<String> userAnswer = GeneratedColumn<String>(
    'user_answer',
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
    correctAnswer,
    unvifiedAnswer,
    userAnswer,
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
    if (data.containsKey('correct_answer')) {
      context.handle(
        _correctAnswerMeta,
        correctAnswer.isAcceptableOrUnknown(
          data['correct_answer']!,
          _correctAnswerMeta,
        ),
      );
    }
    if (data.containsKey('unvified_answer')) {
      context.handle(
        _unvifiedAnswerMeta,
        unvifiedAnswer.isAcceptableOrUnknown(
          data['unvified_answer']!,
          _unvifiedAnswerMeta,
        ),
      );
    }
    if (data.containsKey('user_answer')) {
      context.handle(
        _userAnswerMeta,
        userAnswer.isAcceptableOrUnknown(data['user_answer']!, _userAnswerMeta),
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
      correctAnswer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}correct_answer'],
      ),
      unvifiedAnswer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unvified_answer'],
      ),
      userAnswer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_answer'],
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

  static TypeConverter<Subject, String> $convertersubject =
      const SubjectConverter();
}

class Mistake extends DataClass implements Insertable<Mistake> {
  final int id;
  final Subject subject;
  final String questionHeader;
  final String questionBody;
  final String? correctAnswer;
  final String? unvifiedAnswer;
  final String? userAnswer;
  final DateTime createdAt;
  const Mistake({
    required this.id,
    required this.subject,
    required this.questionHeader,
    required this.questionBody,
    this.correctAnswer,
    this.unvifiedAnswer,
    this.userAnswer,
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
    if (!nullToAbsent || correctAnswer != null) {
      map['correct_answer'] = Variable<String>(correctAnswer);
    }
    if (!nullToAbsent || unvifiedAnswer != null) {
      map['unvified_answer'] = Variable<String>(unvifiedAnswer);
    }
    if (!nullToAbsent || userAnswer != null) {
      map['user_answer'] = Variable<String>(userAnswer);
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
      correctAnswer: correctAnswer == null && nullToAbsent
          ? const Value.absent()
          : Value(correctAnswer),
      unvifiedAnswer: unvifiedAnswer == null && nullToAbsent
          ? const Value.absent()
          : Value(unvifiedAnswer),
      userAnswer: userAnswer == null && nullToAbsent
          ? const Value.absent()
          : Value(userAnswer),
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
      subject: serializer.fromJson<Subject>(json['subject']),
      questionHeader: serializer.fromJson<String>(json['questionHeader']),
      questionBody: serializer.fromJson<String>(json['questionBody']),
      correctAnswer: serializer.fromJson<String?>(json['correctAnswer']),
      unvifiedAnswer: serializer.fromJson<String?>(json['unvifiedAnswer']),
      userAnswer: serializer.fromJson<String?>(json['userAnswer']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'subject': serializer.toJson<Subject>(subject),
      'questionHeader': serializer.toJson<String>(questionHeader),
      'questionBody': serializer.toJson<String>(questionBody),
      'correctAnswer': serializer.toJson<String?>(correctAnswer),
      'unvifiedAnswer': serializer.toJson<String?>(unvifiedAnswer),
      'userAnswer': serializer.toJson<String?>(userAnswer),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Mistake copyWith({
    int? id,
    Subject? subject,
    String? questionHeader,
    String? questionBody,
    Value<String?> correctAnswer = const Value.absent(),
    Value<String?> unvifiedAnswer = const Value.absent(),
    Value<String?> userAnswer = const Value.absent(),
    DateTime? createdAt,
  }) => Mistake(
    id: id ?? this.id,
    subject: subject ?? this.subject,
    questionHeader: questionHeader ?? this.questionHeader,
    questionBody: questionBody ?? this.questionBody,
    correctAnswer: correctAnswer.present
        ? correctAnswer.value
        : this.correctAnswer,
    unvifiedAnswer: unvifiedAnswer.present
        ? unvifiedAnswer.value
        : this.unvifiedAnswer,
    userAnswer: userAnswer.present ? userAnswer.value : this.userAnswer,
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
      correctAnswer: data.correctAnswer.present
          ? data.correctAnswer.value
          : this.correctAnswer,
      unvifiedAnswer: data.unvifiedAnswer.present
          ? data.unvifiedAnswer.value
          : this.unvifiedAnswer,
      userAnswer: data.userAnswer.present
          ? data.userAnswer.value
          : this.userAnswer,
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
          ..write('correctAnswer: $correctAnswer, ')
          ..write('unvifiedAnswer: $unvifiedAnswer, ')
          ..write('userAnswer: $userAnswer, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    subject,
    questionHeader,
    questionBody,
    correctAnswer,
    unvifiedAnswer,
    userAnswer,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Mistake &&
          other.id == this.id &&
          other.subject == this.subject &&
          other.questionHeader == this.questionHeader &&
          other.questionBody == this.questionBody &&
          other.correctAnswer == this.correctAnswer &&
          other.unvifiedAnswer == this.unvifiedAnswer &&
          other.userAnswer == this.userAnswer &&
          other.createdAt == this.createdAt);
}

class MistakesCompanion extends UpdateCompanion<Mistake> {
  final Value<int> id;
  final Value<Subject> subject;
  final Value<String> questionHeader;
  final Value<String> questionBody;
  final Value<String?> correctAnswer;
  final Value<String?> unvifiedAnswer;
  final Value<String?> userAnswer;
  final Value<DateTime> createdAt;
  const MistakesCompanion({
    this.id = const Value.absent(),
    this.subject = const Value.absent(),
    this.questionHeader = const Value.absent(),
    this.questionBody = const Value.absent(),
    this.correctAnswer = const Value.absent(),
    this.unvifiedAnswer = const Value.absent(),
    this.userAnswer = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MistakesCompanion.insert({
    this.id = const Value.absent(),
    required Subject subject,
    required String questionHeader,
    required String questionBody,
    this.correctAnswer = const Value.absent(),
    this.unvifiedAnswer = const Value.absent(),
    this.userAnswer = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : subject = Value(subject),
       questionHeader = Value(questionHeader),
       questionBody = Value(questionBody);
  static Insertable<Mistake> custom({
    Expression<int>? id,
    Expression<String>? subject,
    Expression<String>? questionHeader,
    Expression<String>? questionBody,
    Expression<String>? correctAnswer,
    Expression<String>? unvifiedAnswer,
    Expression<String>? userAnswer,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subject != null) 'subject': subject,
      if (questionHeader != null) 'question_header': questionHeader,
      if (questionBody != null) 'question_body': questionBody,
      if (correctAnswer != null) 'correct_answer': correctAnswer,
      if (unvifiedAnswer != null) 'unvified_answer': unvifiedAnswer,
      if (userAnswer != null) 'user_answer': userAnswer,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MistakesCompanion copyWith({
    Value<int>? id,
    Value<Subject>? subject,
    Value<String>? questionHeader,
    Value<String>? questionBody,
    Value<String?>? correctAnswer,
    Value<String?>? unvifiedAnswer,
    Value<String?>? userAnswer,
    Value<DateTime>? createdAt,
  }) {
    return MistakesCompanion(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      questionHeader: questionHeader ?? this.questionHeader,
      questionBody: questionBody ?? this.questionBody,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      unvifiedAnswer: unvifiedAnswer ?? this.unvifiedAnswer,
      userAnswer: userAnswer ?? this.userAnswer,
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
    if (correctAnswer.present) {
      map['correct_answer'] = Variable<String>(correctAnswer.value);
    }
    if (unvifiedAnswer.present) {
      map['unvified_answer'] = Variable<String>(unvifiedAnswer.value);
    }
    if (userAnswer.present) {
      map['user_answer'] = Variable<String>(userAnswer.value);
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
          ..write('correctAnswer: $correctAnswer, ')
          ..write('unvifiedAnswer: $unvifiedAnswer, ')
          ..write('userAnswer: $userAnswer, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WordsTable words = $WordsTable(this);
  late final $WordLogsTable wordLogs = $WordLogsTable(this);
  late final $MistakesTable mistakes = $MistakesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    words,
    wordLogs,
    mistakes,
  ];
}

typedef $$WordsTableCreateCompanionBuilder =
    WordsCompanion Function({
      Value<int> id,
      required String word,
      Value<String?> definition,
      Value<DateTime> createdAt,
    });
typedef $$WordsTableUpdateCompanionBuilder =
    WordsCompanion Function({
      Value<int> id,
      Value<String> word,
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
          PrefetchHooks Function({bool wordLogsRefs})
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
                Value<String?> definition = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => WordsCompanion(
                id: id,
                word: word,
                definition: definition,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String word,
                Value<String?> definition = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => WordsCompanion.insert(
                id: id,
                word: word,
                definition: definition,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$WordsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({wordLogsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (wordLogsRefs) db.wordLogs],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (wordLogsRefs)
                    await $_getPrefetchedData<Word, $WordsTable, WordLog>(
                      currentTable: table,
                      referencedTable: $$WordsTableReferences
                          ._wordLogsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$WordsTableReferences(db, table, p0).wordLogsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.wordID == item.id),
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
      PrefetchHooks Function({bool wordLogsRefs})
    >;
typedef $$WordLogsTableCreateCompanionBuilder =
    WordLogsCompanion Function({
      Value<int> id,
      required int wordID,
      required LogType type,
      Value<DateTime> timestamp,
      Value<String?> notes,
    });
typedef $$WordLogsTableUpdateCompanionBuilder =
    WordLogsCompanion Function({
      Value<int> id,
      Value<int> wordID,
      Value<LogType> type,
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

  ColumnWithTypeConverterFilters<LogType, LogType, String> get type =>
      $composableBuilder(
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

  GeneratedColumnWithTypeConverter<LogType, String> get type =>
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
                Value<LogType> type = const Value.absent(),
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
                required LogType type,
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
typedef $$MistakesTableCreateCompanionBuilder =
    MistakesCompanion Function({
      Value<int> id,
      required Subject subject,
      required String questionHeader,
      required String questionBody,
      Value<String?> correctAnswer,
      Value<String?> unvifiedAnswer,
      Value<String?> userAnswer,
      Value<DateTime> createdAt,
    });
typedef $$MistakesTableUpdateCompanionBuilder =
    MistakesCompanion Function({
      Value<int> id,
      Value<Subject> subject,
      Value<String> questionHeader,
      Value<String> questionBody,
      Value<String?> correctAnswer,
      Value<String?> unvifiedAnswer,
      Value<String?> userAnswer,
      Value<DateTime> createdAt,
    });

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

  ColumnFilters<String> get correctAnswer => $composableBuilder(
    column: $table.correctAnswer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unvifiedAnswer => $composableBuilder(
    column: $table.unvifiedAnswer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userAnswer => $composableBuilder(
    column: $table.userAnswer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
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

  ColumnOrderings<String> get correctAnswer => $composableBuilder(
    column: $table.correctAnswer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unvifiedAnswer => $composableBuilder(
    column: $table.unvifiedAnswer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userAnswer => $composableBuilder(
    column: $table.userAnswer,
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

  GeneratedColumn<String> get correctAnswer => $composableBuilder(
    column: $table.correctAnswer,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unvifiedAnswer => $composableBuilder(
    column: $table.unvifiedAnswer,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userAnswer => $composableBuilder(
    column: $table.userAnswer,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
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
          (Mistake, BaseReferences<_$AppDatabase, $MistakesTable, Mistake>),
          Mistake,
          PrefetchHooks Function()
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
                Value<String?> correctAnswer = const Value.absent(),
                Value<String?> unvifiedAnswer = const Value.absent(),
                Value<String?> userAnswer = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MistakesCompanion(
                id: id,
                subject: subject,
                questionHeader: questionHeader,
                questionBody: questionBody,
                correctAnswer: correctAnswer,
                unvifiedAnswer: unvifiedAnswer,
                userAnswer: userAnswer,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required Subject subject,
                required String questionHeader,
                required String questionBody,
                Value<String?> correctAnswer = const Value.absent(),
                Value<String?> unvifiedAnswer = const Value.absent(),
                Value<String?> userAnswer = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MistakesCompanion.insert(
                id: id,
                subject: subject,
                questionHeader: questionHeader,
                questionBody: questionBody,
                correctAnswer: correctAnswer,
                unvifiedAnswer: unvifiedAnswer,
                userAnswer: userAnswer,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
      (Mistake, BaseReferences<_$AppDatabase, $MistakesTable, Mistake>),
      Mistake,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WordsTableTableManager get words =>
      $$WordsTableTableManager(_db, _db.words);
  $$WordLogsTableTableManager get wordLogs =>
      $$WordLogsTableTableManager(_db, _db.wordLogs);
  $$MistakesTableTableManager get mistakes =>
      $$MistakesTableTableManager(_db, _db.mistakes);
}
