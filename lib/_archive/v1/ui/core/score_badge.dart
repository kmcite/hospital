// import 'package:flutter/material.dart';
// import 'package:hospital/main.dart';
// import 'package:hospital/domain/models/score.dart';
// import 'package:hospital/domain/repositories/score_repository.dart';

// mixin ScoreBadgeBloc {
//   Score get score => scoreRepository.current;
// }

// class ScoreBadge extends UI with ScoreBadgeBloc {
//   @override
//   Widget build(context) {
//     return Badge(
//       backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
//       label: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             '${score.points}',
//             style: TextStyle(
//               color: Theme.of(context).colorScheme.onTertiaryContainer,
//             ),
//           ),
//           if (score.points > 0 && score.points == score.highScore)
//             Padding(
//               padding: const EdgeInsets.only(left: 2),
//               child: Icon(
//                 Icons.emoji_events,
//                 size: 12,
//                 color: Theme.of(context).colorScheme.onTertiaryContainer,
//               ),
//             ),
//         ],
//       ),
//       largeSize: 24,
//     );
//   }
// }
