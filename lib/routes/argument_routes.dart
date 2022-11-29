import 'package:flutter/material.dart';
import 'package:pmdc_lms/views/screens/subjects/assignments_screen.dart';
import 'package:pmdc_lms/views/screens/subjects/static_mcqs_screen.dart';
import 'package:pmdc_lms/views/screens/subjects/record_generate_mcqs_screen.dart';
import 'package:pmdc_lms/views/screens/subjects/lecture_videos_screen.dart';
import 'package:pmdc_lms/views/screens/subjects/mcqs_screen.dart';
import 'package:pmdc_lms/views/screens/subjects/subject_notes_screen.dart';
import 'package:pmdc_lms/views/screens/subjects/model_paper_screen.dart';
import 'package:pmdc_lms/views/screens/subjects/query_to_teacher_screen.dart';
import 'package:pmdc_lms/views/screens/subjects/subject_detail_screen.dart';
import 'package:pmdc_lms/views/screens/subjects/subject_diary_detail_screen.dart';
import 'package:pmdc_lms/views/screens/subjects/syllabus_screen.dart';

class ArgumentRoutes {
  static Route? Function(RouteSettings)? onGenerateRoutes =
      (RouteSettings settings) {
    if (settings.name == SubjectDetailScreen.id) {
      final args = settings.arguments as SubjectDetailArgs;

      return MaterialPageRoute(
        builder: (context) {
          return SubjectDetailScreen(
            subject: args.subject,
            isUrdu: args.isUrdu,
            teacherID: args.teacherID,
          );
        },
      );
    }
    if (settings.name == QueryToTeacherScreen.id) {
      final args = settings.arguments as QueryToTeacherArgs;

      return MaterialPageRoute(
        builder: (context) {
          return QueryToTeacherScreen(
            subject: args.subject,
            isUrdu: args.isUrdu,
            teacherID: args.teacherID,
          );
        },
      );
    }
    if (settings.name == ModelPaperScreen.id) {
      final args = settings.arguments as ModelPaperArgs;

      return MaterialPageRoute(
        builder: (context) {
          return ModelPaperScreen(
            subject: args.subject,
            isUrdu: args.isUrdu,
          );
        },
      );
    }
    if (settings.name == SubjectDiaryDetailScreen.id) {
      final args = settings.arguments as SubjectDiaryDetailArgs;

      return MaterialPageRoute(
        builder: (context) {
          return SubjectDiaryDetailScreen(
            subject: args.subject,
            isUrdu: args.isUrdu,
          );
        },
      );
    }
    if (settings.name == SubjectNotesScreen.id) {
      final args = settings.arguments as NotesArgs;

      return MaterialPageRoute(
        builder: (context) {
          return SubjectNotesScreen(
            subject: args.subject,
            isUrdu: args.isUrdu,
          );
        },
      );
    }
    if (settings.name == AssignmentsScreen.id) {
      final args = settings.arguments as AssignmentArgs;

      return MaterialPageRoute(
        builder: (context) {
          return AssignmentsScreen(
            subject: args.subject,
            isUrdu: args.isUrdu,
          );
        },
      );
    }
    if (settings.name == SyllabusScreen.id) {
      final args = settings.arguments as SyllabusArgs;

      return MaterialPageRoute(
        builder: (context) {
          return SyllabusScreen(
            subject: args.subject,
            isUrdu: args.isUrdu,
          );
        },
      );
    }

    if (settings.name == LectureVideosScreen.id) {
      final args = settings.arguments as LectureArgs;

      return MaterialPageRoute(
        builder: (context) {
          return LectureVideosScreen(
            subject: args.subject,
            isUrdu: args.isUrdu,
          );
        },
      );
    }

    if (settings.name == McqsScreen.id) {
      final args = settings.arguments as McqsArgs;

      return MaterialPageRoute(
        builder: (context) {
          return McqsScreen(
            subject: args.subject,
            isUrdu: args.isUrdu,
          );
        },
      );
    }
    if (settings.name == GenerateMcqsScreen.id) {
      final args = settings.arguments as GeneratemcqsArgs;

      return MaterialPageRoute(
        builder: (context) {
          return GenerateMcqsScreen(
            subject: args.subject,
            isUrdu: args.isUrdu,
          );
        },
      );
    }

    if (settings.name == AttemptStaticMcqs.id) {
      final args = settings.arguments as AttemptstaticArgs;

      return MaterialPageRoute(
        builder: (context) {
          return AttemptStaticMcqs(
              subject: args.subject,
              isUrdu: args.isUrdu,
              chapter: args.chapter);
        },
      );
    }
    return null;
  };
}

//Classes for passing arguments
class SubjectDiaryDetailArgs {
  final String subject;
  final String isUrdu;

  SubjectDiaryDetailArgs(this.subject, this.isUrdu);
}

class McqsArgs {
  final String subject;
  final String isUrdu;

  McqsArgs(
    this.subject,
    this.isUrdu,
  );
}

class GeneratemcqsArgs {
  final String subject;
  final String isUrdu;

  GeneratemcqsArgs(
    this.subject,
    this.isUrdu,
  );
}

class SubjectDetailArgs {
  final String subject;
  final String isUrdu;
  final String teacherID;

  SubjectDetailArgs(this.subject, this.isUrdu, this.teacherID);
}

class QueryToTeacherArgs {
  final String subject;
  final String isUrdu;
  final String teacherID;

  QueryToTeacherArgs(this.subject, this.isUrdu, this.teacherID);
}

class AssignmentArgs {
  final String subject;
  final String isUrdu;

  AssignmentArgs(this.subject, this.isUrdu);
}

class NotesArgs {
  final String subject;
  final String isUrdu;

  NotesArgs(this.subject, this.isUrdu);
}

class LectureArgs {
  final String subject;
  final String isUrdu;

  LectureArgs(this.subject, this.isUrdu);
}

class SyllabusArgs {
  final String subject;
  final String isUrdu;

  SyllabusArgs(this.subject, this.isUrdu);
}

class ModelPaperArgs {
  final String subject;
  final String isUrdu;

  ModelPaperArgs(this.subject, this.isUrdu);
}

class AttemptArgs {
  final String subject;
  final String isUrdu;
  final String chapter;

  AttemptArgs(this.subject, this.isUrdu, this.chapter);
}

class AttemptstaticArgs {
  final String subject;
  final String isUrdu;
  final String chapter;

  AttemptstaticArgs(this.subject, this.isUrdu, this.chapter);
}
