import 'package:hive/hive.dart';

import '../data.dart';

bool hasPDF(Buch buch) => (Hive.box('pdf').get(buch.path()) != null);

List<int> listGen(int start, int length) {
  return List<int>.generate(length, (i) => start + i);
}

List<int> getPDFPageNumbers(Buch buch, int? nummer) {
  switch (buch) {
    case Buch.gesangbuch:
      switch (nummer) {
        case 1:
          return listGen(0, 3);
        case 2:
          return listGen(3, 3);
        case 3:
          return listGen(6, 1);
        case 4:
          return listGen(7, 2);
        case 5:
          return listGen(9, 2);
        case 6:
          return listGen(11, 3);
        case 7:
          return listGen(14, 3);
        case 8:
          return listGen(17, 3);
        case 9:
          return listGen(20, 2);
        case 10:
          return listGen(22, 3);
        case 11:
          return listGen(25, 3);
        case 12:
          return listGen(28, 4);
        case 13:
          return listGen(32, 2);
        case 14:
          return listGen(34, 3);
        case 15:
          return listGen(37, 3);
        case 16:
          return listGen(40, 2);
        case 17:
          return listGen(42, 3);
        case 18:
          return listGen(45, 1);
        case 19:
          return listGen(46, 2);
        case 20:
          return listGen(48, 4);
        case 21:
          return listGen(52, 2);
        case 22:
          return listGen(54, 2);
        case 23:
          return listGen(56, 2);
        case 24:
          return listGen(58, 1);
        case 25:
          return listGen(59, 1);
        case 26:
          return listGen(60, 2);
        case 27:
          return listGen(62, 3);
        case 28:
          return listGen(65, 3);
        case 29:
          return listGen(68, 2);
        case 30:
          return listGen(70, 3);
        case 31:
          return listGen(73, 2);
        case 32:
          return listGen(75, 1);
        case 33:
          return listGen(76, 3);
        case 34:
          return listGen(79, 3);
        case 35:
          return listGen(82, 3);
        case 36:
          return listGen(85, 4);
        case 37:
          return listGen(89, 3);
        case 38:
          return listGen(92, 1);
        case 39:
          return listGen(93, 3);
        case 40:
          return listGen(96, 3);
        case 41:
          return listGen(99, 3);
        case 42:
          return listGen(102, 2);
        case 43:
          return listGen(104, 5);
        case 44:
          return listGen(109, 3);
        case 45:
          return listGen(112, 2);
        case 46:
          return listGen(113, 2);
        case 47:
          return listGen(115, 1);
        case 48:
          return listGen(116, 4);
        case 49:
          return listGen(120, 3);
        case 50:
          return listGen(123, 2);
        case 51:
          return listGen(125, 3);
        case 52:
          return listGen(128, 3);
        case 53:
          return listGen(131, 2);
        case 54:
          return listGen(133, 1);
        case 55:
          return listGen(134, 3);
        case 56:
          return listGen(137, 2);
        case 57:
          return listGen(139, 1);
        case 58:
          return listGen(140, 1);
        case 59:
          return listGen(141, 2);
        case 60:
          return listGen(143, 3);
        case 61:
          return listGen(146, 1);
        case 62:
          return listGen(147, 1);
        case 63:
          return listGen(148, 3);
        case 64:
          return listGen(151, 2);
        case 65:
          return listGen(153, 5);
        case 66:
          return listGen(158, 3);
        case 67:
          return listGen(161, 2);
        case 68:
          return listGen(163, 3);
        case 69:
          return listGen(166, 3);
        case 70:
          return listGen(169, 2);
        case 71:
          return listGen(171, 3);
        case 72:
          return listGen(174, 2);
        case 73:
          return listGen(176, 3);
        case 74:
          return listGen(179, 3);
        case 75:
          return listGen(182, 3);
        case 76:
          return listGen(185, 1);
        case 77:
          return listGen(186, 4);
        case 78:
          return listGen(190, 3);
        case 79:
          return listGen(192, 3);
        case 80:
          return listGen(195, 1);
        case 81:
          return listGen(196, 3);
        case 82:
          return listGen(199, 2);
        case 83:
          return listGen(201, 1);
        case 84:
          return listGen(202, 4);
        case 85:
          return listGen(206, 3);
        case 86:
          return listGen(209, 2);
        case 87:
          return listGen(210, 2);
        case 88:
          return listGen(211, 2);
        case 89:
          return listGen(213, 2);
        case 90:
          return listGen(215, 2);
        case 91:
          return listGen(216, 2);
        case 92:
          return listGen(218, 2);
        case 93:
          return listGen(220, 2);
        case 94:
          return listGen(222, 4);
        case 95:
          return listGen(226, 3);
        case 96:
          return listGen(229, 4);
        case 97:
          return listGen(233, 1);
        case 98:
          return listGen(234, 2);
        case 99:
          return listGen(236, 1);
        case 100:
          return listGen(237, 2);
        case 101:
          return listGen(239, 2);
        case 102:
          return listGen(241, 2);
        case 103:
          return listGen(243, 4);
        case 104:
          return listGen(247, 2);
        case 105:
          return listGen(249, 2);
        case 106:
          return listGen(251, 1);
        case 107:
          return listGen(252, 6);
        case 108:
          return listGen(258, 2);
        case 109:
          return listGen(260, 2);
        case 110:
          return listGen(262, 2);
        case 111:
          return listGen(264, 3);
        case 112:
          return listGen(267, 1);
        case 113:
          return listGen(268, 2);
        case 114:
          return listGen(270, 3);
        case 115:
          return listGen(273, 1);
        case 116:
          return listGen(274, 3);
        case 117:
          return listGen(277, 2);
        case 118:
          return listGen(279, 7);
        case 119:
          return listGen(286, 2);
        case 120:
          return listGen(288, 3);
        case 121:
          return listGen(291, 1);
        case 122:
          return listGen(292, 1);
        case 123:
          return listGen(293, 3);
        case 124:
          return listGen(296, 1);
        case 125:
          return listGen(297, 2);
        case 126:
          return listGen(299, 3);
        case 127:
          return listGen(302, 3);
        case 128:
          return listGen(305, 3);
        case 129:
          return listGen(308, 3);
        case 130:
          return listGen(311, 4);
        case 131:
          return listGen(315, 3);
        case 132:
          return listGen(318, 3);
        case 133:
          return listGen(321, 2);
        case 134:
          return listGen(323, 3);
        case 135:
          return listGen(326, 1);
        case 136:
          return listGen(327, 3);
        case 137:
          return listGen(330, 3);
        case 138:
          return listGen(333, 3);
        case 139:
          return listGen(336, 1);
        case 140:
          return listGen(337, 3);
        case 141:
          return listGen(340, 3);
        case 142:
          return listGen(343, 2);
        case 143:
          return listGen(345, 5);
        case 144:
          return listGen(350, 4);
        case 145:
          return listGen(354, 3);
        case 146:
          return listGen(357, 10);
        case 147:
          return listGen(367, 2);
        case 148:
          return listGen(369, 2);
        case 149:
          return listGen(371, 3);
        case 150:
          return listGen(374, 2);
        case 151:
          return listGen(376, 3);
        case 152:
          return listGen(379, 1);
        case 153:
          return listGen(380, 3);
        case 154:
          return listGen(383, 2);
        case 155:
          return listGen(385, 2);
        case 156:
          return listGen(387, 3);
        case 157:
          return listGen(390, 3);
        case 158:
          return listGen(393, 6);
        case 159:
          return listGen(399, 7);
        case 160:
          return listGen(406, 3);
        case 161:
          return listGen(409, 3);
        case 162:
          return listGen(412, 3);
        case 163:
          return listGen(415, 1);
        case 164:
          return listGen(416, 1);
        case 165:
          return listGen(417, 3);
        case 166:
          return listGen(420, 4);
        case 167:
          return listGen(424, 3);
        case 168:
          return listGen(427, 5);
        case 169:
          return listGen(432, 2);
        case 170:
          return listGen(434, 1);
        case 171:
          return listGen(435, 5);
        case 172:
          return listGen(440, 3);
        case 173:
          return listGen(443, 1);
        case 174:
          return listGen(444, 1);
        case 175:
          return listGen(445, 3);
        case 176:
          return listGen(448, 3);
        case 177:
          return listGen(451, 1);
        case 178:
          return listGen(452, 2);
        case 179:
          return listGen(454, 1);
        case 180:
          return listGen(455, 3);
        case 181:
          return listGen(458, 2);
        case 182:
          return listGen(460, 4);
        case 183:
          return listGen(464, 7);
        case 184:
          return listGen(471, 1);
        case 185:
          return listGen(472, 2);
        case 186:
          return listGen(474, 2);
        case 187:
          return listGen(476, 1);
        case 188:
          return listGen(477, 3);
        case 189:
          return listGen(480, 5);
        case 190:
          return listGen(485, 3);
        case 191:
          return listGen(488, 2);
        case 192:
          return listGen(490, 4);
        case 193:
          return listGen(494, 5);
        case 194:
          return listGen(499, 3);
        case 195:
          return listGen(502, 3);
        case 196:
          return listGen(505, 3);
        case 197:
          return listGen(508, 2);
        case 198:
          return listGen(510, 2);
        case 199:
          return listGen(512, 5);
        case 200:
          return listGen(517, 1);
        case 201:
          return listGen(518, 2);
        case 202:
          return listGen(520, 3);
        case 203:
          return listGen(523, 2);
        case 204:
          return listGen(525, 1);
        case 205:
          return listGen(526, 3);
        case 206:
          return listGen(529, 3);
        case 207:
          return listGen(532, 2);
        case 208:
          return listGen(534, 3);
        case 209:
          return listGen(537, 2);
        case 210:
          return listGen(539, 1);
        case 211:
          return listGen(540, 3);
        case 212:
          return listGen(543, 3);
        case 213:
          return listGen(546, 2);
        case 214:
          return listGen(548, 2);
        case 215:
          return listGen(550, 3);
        case 216:
          return listGen(553, 2);
        case 217:
          return listGen(555, 3);
        case 218:
          return listGen(558, 4);
        case 219:
          return listGen(562, 3);
        case 220:
          return listGen(565, 3);
        case 221:
          return listGen(568, 3);
        case 222:
          return listGen(571, 3);
        case 223:
          return listGen(574, 2);
        case 224:
          return listGen(576, 3);
        case 225:
          return listGen(579, 3);
        case 226:
          return listGen(582, 1);
        case 227:
          return listGen(583, 2);
        case 228:
          return listGen(585, 4);
        case 229:
          return listGen(589, 3);
        case 230:
          return listGen(592, 1);
        case 231:
          return listGen(593, 2);
        case 232:
          return listGen(595, 2);
        case 233:
          return listGen(597, 4);
        case 234:
          return listGen(601, 2);
        case 235:
          return listGen(603, 1);
        case 236:
          return listGen(604, 4);
        case 237:
          return listGen(608, 3);
        case 238:
          return listGen(611, 2);
        case 239:
          return listGen(613, 6);
        case 240:
          return listGen(619, 5);
        case 241:
          return listGen(624, 1);
        case 242:
          return listGen(625, 2);
        case 243:
          return listGen(627, 3);
        case 244:
          return listGen(630, 3);
        case 245:
          return listGen(633, 5);
        case 246:
          return listGen(638, 3);
        case 247:
          return listGen(641, 3);
        case 248:
          return listGen(644, 3);
        case 249:
          return listGen(647, 2);
        case 250:
          return listGen(649, 3);
        case 251:
          return listGen(652, 2);
        case 252:
          return listGen(654, 2);
        case 253:
          return listGen(656, 3);
        case 254:
          return listGen(659, 3);
        case 255:
          return listGen(662, 5);
        case 256:
          return listGen(667, 6);
        case 257:
          return listGen(673, 4);
        case 258:
          return listGen(677, 3);
        case 259:
          return listGen(679, 3);
        case 260:
          return listGen(682, 5);
        case 261:
          return listGen(687, 2);
        case 262:
          return listGen(689, 3);
        case 263:
          return listGen(692, 2);
        case 264:
          return listGen(694, 1);
        case 265:
          return listGen(695, 4);
        case 266:
          return listGen(699, 5);
        case 267:
          return listGen(704, 5);
        case 268:
          return listGen(709, 2);
        case 269:
          return listGen(711, 1);
        case 270:
          return listGen(712, 3);
        case 271:
          return listGen(715, 2);
        case 272:
          return listGen(717, 4);
        case 273:
          return listGen(721, 2);
        case 274:
          return listGen(723, 2);
        case 275:
          return listGen(725, 5);
        case 276:
          return listGen(729, 2);
        case 277:
          return listGen(731, 5);
        case 278:
          return listGen(736, 2);
        case 279:
          return listGen(738, 1);
        case 280:
          return listGen(739, 5);
        case 281:
          return listGen(744, 3);
        case 282:
          return listGen(746, 4);
        case 283:
          return listGen(749, 2);
        case 284:
          return listGen(751, 2);
        case 285:
          return listGen(753, 2);
        case 286:
          return listGen(755, 1);
        case 287:
          return listGen(756, 3);
        case 288:
          return listGen(759, 1);
        case 289:
          return listGen(760, 2);
        case 290:
          return listGen(762, 3);
        case 291:
          return listGen(765, 3);
        case 292:
          return listGen(768, 6);
        case 293:
          return listGen(774, 4);
        case 294:
          return listGen(778, 1);
        case 295:
          return listGen(779, 3);
        case 296:
          return listGen(782, 2);
        case 297:
          return listGen(784, 3);
        case 298:
          return listGen(787, 2);
        case 299:
          return listGen(789, 2);
        case 300:
          return listGen(791, 3);
        case 301:
          return listGen(794, 1);
        case 302:
          return listGen(795, 1);
        case 303:
          return listGen(796, 1);
        case 304:
          return listGen(797, 3);
        case 305:
          return listGen(800, 2);
        case 306:
          return listGen(802, 2);
        case 307:
          return listGen(804, 2);
        case 308:
          return listGen(806, 1);
        case 309:
          return listGen(807, 3);
        case 310:
          return listGen(810, 2);
        case 311:
          return listGen(812, 2);
        case 312:
          return listGen(814, 2);
        case 313:
          return listGen(816, 3);
        case 314:
          return listGen(819, 3);
        case 315:
          return listGen(821, 5);
        case 316:
          return listGen(826, 2);
        case 317:
          return listGen(828, 3);
        case 318:
          return listGen(831, 3);
        case 319:
          return listGen(834, 7);
        case 320:
          return listGen(840, 3);
        case 321:
          return listGen(843, 5);
        case 322:
          return listGen(848, 3);
        case 323:
          return listGen(851, 4);
        case 324:
          return listGen(855, 1);
        case 325:
          return listGen(856, 3);
        case 326:
          return listGen(859, 2);
        case 327:
          return listGen(861, 2);
        case 328:
          return listGen(863, 3);
        case 329:
          return listGen(866, 2);
        case 330:
          return listGen(868, 2);
        case 331:
          return listGen(870, 3);
        case 332:
          return listGen(873, 3);
        case 333:
          return listGen(876, 3);
        case 334:
          return listGen(879, 2);
        case 335:
          return listGen(881, 5);
        case 336:
          return listGen(886, 2);
        case 337:
          return listGen(888, 1);
        case 338:
          return listGen(889, 4);
        case 339:
          return listGen(893, 1);
        case 340:
          return listGen(894, 3);
        case 341:
          return listGen(897, 3);
        case 342:
          return listGen(899, 4);
        case 343:
          return listGen(902, 4);
        case 344:
          return listGen(906, 4);
        case 345:
          return listGen(910, 1);
        case 346:
          return listGen(911, 3);
        case 347:
          return listGen(914, 3);
        case 348:
          return listGen(917, 7);
        case 349:
          return listGen(924, 2);
        case 350:
          return listGen(926, 3);
        case 351:
          return listGen(929, 2);
        case 352:
          return listGen(931, 2);
        case 353:
          return listGen(933, 1);
        case 354:
          return listGen(934, 1);
        case 355:
          return listGen(935, 1);
        case 356:
          return listGen(936, 2);
        case 357:
          return listGen(938, 1);
        case 358:
          return listGen(939, 2);
        case 359:
          return listGen(941, 4);
        case 360:
          return listGen(945, 1);
        case 361:
          return listGen(946, 2);
        case 362:
          return listGen(948, 2);
        case 363:
          return listGen(950, 3);
        case 364:
          return listGen(953, 3);
        case 365:
          return listGen(956, 2);
        case 366:
          return listGen(958, 5);
        case 367:
          return listGen(963, 3);
        case 368:
          return listGen(966, 1);
        case 369:
          return listGen(967, 1);
        case 370:
          return listGen(968, 3);
        case 371:
          return listGen(971, 3);
        case 372:
          return listGen(973, 3);
        case 373:
          return listGen(976, 3);
        case 374:
          return listGen(979, 2);
        case 375:
          return listGen(981, 3);
        case 376:
          return listGen(984, 3);
        case 377:
          return listGen(987, 2);
        case 378:
          return listGen(989, 1);
        case 379:
          return listGen(990, 3);
        case 380:
          return listGen(993, 2);
        case 381:
          return listGen(995, 3);
        case 382:
          return listGen(998, 5);
        case 383:
          return listGen(1003, 3);
        case 384:
          return listGen(1006, 3);
        case 385:
          return listGen(1009, 1);
        case 386:
          return listGen(1010, 4);
        case 387:
          return listGen(1014, 2);
        case 388:
          return listGen(1016, 4);
        case 389:
          return listGen(1020, 2);
        case 390:
          return listGen(1022, 2);
        case 391:
          return listGen(1024, 1);
        case 392:
          return listGen(1025, 2);
        case 393:
          return listGen(1027, 2);
        case 394:
          return listGen(1029, 1);
        case 395:
          return listGen(1030, 3);
        case 396:
          return listGen(1033, 2);
        case 397:
          return listGen(1035, 3);
        case 398:
          return listGen(1038, 3);
        case 399:
          return listGen(1041, 2);
        case 400:
          return listGen(1043, 2);
        case 401:
          return listGen(1045, 2);
        case 402:
          return listGen(1047, 4);
        case 403:
          return listGen(1051, 3);
        case 404:
          return listGen(1054, 4);
        case 405:
          return listGen(1058, 3);
        case 406:
          return listGen(1060, 3);
        case 407:
          return listGen(1063, 2);
        case 408:
          return listGen(1065, 3);
        case 409:
          return listGen(1068, 2);
        case 410:
          return listGen(1070, 3);
        case 411:
          return listGen(1073, 3);
        case 412:
          return listGen(1076, 5);
        case 413:
          return listGen(1081, 2);
        case 414:
          return listGen(1083, 3);
        case 415:
          return listGen(1086, 6);
        case 416:
          return listGen(1092, 3);
        case 417:
          return listGen(1095, 4);
        case 418:
          return listGen(1099, 2);
        case 419:
          return listGen(1101, 3);
        case 420:
          return listGen(1104, 1);
        case 421:
          return listGen(1105, 4);
        case 422:
          return listGen(1109, 3);
        case 423:
          return listGen(1112, 3);
        case 424:
          return listGen(1115, 3);
        case 425:
          return listGen(1118, 2);
        case 426:
          return listGen(1120, 2);
        case 427:
          return listGen(1122, 1);
        case 428:
          return listGen(1123, 4);
        case 429:
          return listGen(1127, 2);
        case 430:
          return listGen(1129, 4);
        case 431:
          return listGen(1133, 1);
        case 432:
          return listGen(1134, 1);
        case 433:
          return listGen(1135, 4);
        case 434:
          return listGen(1139, 2);
        case 435:
          return listGen(1141, 3);
        case 436:
          return listGen(1144, 3);
        case 437:
          return listGen(1147, 3);
        case 438:
          return listGen(1150, 3);
        default:
          return List.empty();
      }
    case Buch.chorbuch:
      switch (nummer) {
        case 1:
          return listGen(6, 1);
        case 2:
          return listGen(7, 1);
        case 3:
          return listGen(8, 2);
        case 4:
          return listGen(10, 3);
        case 5:
          return listGen(13, 1);
        case 6:
          return listGen(14, 1);
        case 7:
          return listGen(15, 1);
        case 8:
          return listGen(16, 1);
        case 9:
          return listGen(17, 1);
        case 10:
          return listGen(18, 3);
        case 11:
          return listGen(21, 1);
        case 12:
          return listGen(22, 2);
        case 13:
          return listGen(24, 2);
        case 14:
          return listGen(26, 1);
        case 15:
          return listGen(27, 1);
        case 16:
          return listGen(28, 4);
        case 17:
          return listGen(32, 1);
        case 18:
          return listGen(33, 2);
        case 19:
          return listGen(35, 3);
        case 20:
          return listGen(38, 2);
        case 21:
          return listGen(40, 2);
        case 22:
          return listGen(42, 2);
        case 23:
          return listGen(44, 2);
        case 24:
          return listGen(46, 1);
        case 25:
          return listGen(47, 1);
        case 26:
          return listGen(48, 2);
        case 27:
          return listGen(50, 2);
        case 28:
          return listGen(52, 1);
        case 29:
          return listGen(53, 2);
        case 30:
          return listGen(55, 3);
        case 31:
          return listGen(58, 1);
        case 32:
          return listGen(59, 1);
        case 33:
          return listGen(60, 1);
        case 34:
          return listGen(61, 1);
        case 35:
          return listGen(62, 1);
        case 36:
          return listGen(63, 1);
        case 37:
          return listGen(64, 2);
        case 38:
          return listGen(66, 1);
        case 39:
          return listGen(67, 2);
        case 40:
          return listGen(69, 1);
        case 41:
          return listGen(70, 1);
        case 42:
          return listGen(71, 1);
        case 43:
          return listGen(72, 2);
        case 44:
          return listGen(74, 1);
        case 45:
          return listGen(75, 2);
        case 46:
          return listGen(77, 2);
        case 47:
          return listGen(79, 1);
        case 48:
          return listGen(80, 2);
        case 49:
          return listGen(82, 1);
        case 50:
          return listGen(83, 2);
        case 51:
          return listGen(85, 2);
        case 52:
          return listGen(87, 1);
        case 53:
          return listGen(88, 1);
        case 54:
          return listGen(89, 1);
        case 55:
          return listGen(90, 1);
        case 56:
          return listGen(91, 2);
        case 57:
          return listGen(93, 2);
        case 58:
          return listGen(95, 1);
        case 59:
          return listGen(96, 2);
        case 60:
          return listGen(98, 2);
        case 61:
          return listGen(100, 1);
        case 62:
          return listGen(101, 1);
        case 63:
          return listGen(102, 2);
        case 64:
          return listGen(104, 2);
        case 65:
          return listGen(106, 1);
        case 66:
          return listGen(107, 2);
        case 67:
          return listGen(109, 2);
        case 68:
          return listGen(111, 2);
        case 69:
          return listGen(113, 1);
        case 70:
          return listGen(114, 2);
        case 71:
          return listGen(116, 2);
        case 72:
          return listGen(118, 1);
        case 73:
          return listGen(119, 1);
        case 74:
          return listGen(120, 1);
        case 75:
          return listGen(121, 1);
        case 76:
          return listGen(122, 3);
        case 77:
          return listGen(125, 2);
        case 78:
          return listGen(127, 1);
        case 79:
          return listGen(128, 1);
        case 80:
          return listGen(129, 1);
        case 81:
          return listGen(130, 1);
        case 82:
          return listGen(131, 3);
        case 83:
          return listGen(134, 2);
        case 84:
          return listGen(136, 2);
        case 85:
          return listGen(138, 2);
        case 86:
          return listGen(140, 2);
        case 87:
          return listGen(142, 1);
        case 88:
          return listGen(143, 1);
        case 89:
          return listGen(144, 2);
        case 90:
          return listGen(146, 2);
        case 91:
          return listGen(148, 1);
        case 92:
          return listGen(149, 2);
        case 93:
          return listGen(151, 1);
        case 94:
          return listGen(152, 2);
        case 95:
          return listGen(154, 1);
        case 96:
          return listGen(155, 1);
        case 97:
          return listGen(157, 1);
        case 98:
          return listGen(158, 3);
        case 99:
          return listGen(161, 2);
        case 100:
          return listGen(163, 1);
        case 101:
          return listGen(164, 2);
        case 102:
          return listGen(166, 1);
        case 103:
          return listGen(167, 2);
        case 104:
          return listGen(169, 2);
        case 105:
          return listGen(171, 1);
        case 106:
          return listGen(172, 1);
        case 107:
          return listGen(173, 2);
        case 108:
          return listGen(175, 2);
        case 109:
          return listGen(177, 2);
        case 110:
          return listGen(179, 4);
        case 111:
          return listGen(183, 3);
        case 112:
          return listGen(186, 2);
        case 113:
          return listGen(188, 4);
        case 114:
          return listGen(192, 2);
        case 115:
          return listGen(194, 2);
        case 116:
          return listGen(196, 1);
        case 117:
          return listGen(197, 1);
        case 118:
          return listGen(198, 1);
        case 119:
          return listGen(199, 1);
        case 120:
          return listGen(200, 2);
        case 121:
          return listGen(202, 1);
        case 122:
          return listGen(203, 2);
        case 123:
          return listGen(205, 3);
        case 124:
          return listGen(208, 1);
        case 125:
          return listGen(209, 3);
        case 126:
          return listGen(212, 1);
        case 127:
          return listGen(213, 1);
        case 128:
          return listGen(214, 1);
        case 129:
          return listGen(215, 2);
        case 130:
          return listGen(217, 2);
        case 131:
          return listGen(219, 2);
        case 132:
          return listGen(221, 3);
        case 133:
          return listGen(224, 1);
        case 134:
          return listGen(225, 1);
        case 135:
          return listGen(226, 1);
        case 136:
          return listGen(227, 1);
        case 137:
          return listGen(228, 2);
        case 138:
          return listGen(230, 1);
        case 139:
          return listGen(231, 2);
        case 140:
          return listGen(233, 2);
        case 141:
          return listGen(235, 1);
        case 142:
          return listGen(236, 1);
        case 143:
          return listGen(237, 1);
        case 144:
          return listGen(238, 1);
        case 145:
          return listGen(239, 1);
        case 146:
          return listGen(240, 2);
        case 147:
          return listGen(242, 1);
        case 148:
          return listGen(243, 2);
        case 149:
          return listGen(245, 2);
        case 150:
          return listGen(247, 1);
        case 151:
          return listGen(248, 2);
        case 152:
          return listGen(250, 2);
        case 153:
          return listGen(252, 1);
        case 154:
          return listGen(253, 2);
        case 155:
          return listGen(255, 2);
        case 156:
          return listGen(257, 2);
        case 157:
          return listGen(259, 1);
        case 158:
          return listGen(260, 2);
        case 159:
          return listGen(262, 1);
        case 160:
          return listGen(263, 3);
        case 161:
          return listGen(266, 1);
        case 162:
          return listGen(267, 3);
        case 163:
          return listGen(270, 2);
        case 164:
          return listGen(272, 1);
        case 165:
          return listGen(273, 2);
        case 166:
          return listGen(275, 1);
        case 167:
          return listGen(276, 1);
        case 168:
          return listGen(277, 1);
        case 169:
          return listGen(278, 1);
        case 170:
          return listGen(279, 2);
        case 171:
          return listGen(281, 2);
        case 172:
          return listGen(283, 1);
        case 173:
          return listGen(284, 1);
        case 174:
          return listGen(285, 2);
        case 175:
          return listGen(287, 2);
        case 176:
          return listGen(289, 1);
        case 177:
          return listGen(290, 1);
        case 178:
          return listGen(291, 1);
        case 179:
          return listGen(292, 1);
        case 180:
          return listGen(293, 2);
        case 181:
          return listGen(295, 1);
        case 182:
          return listGen(296, 2);
        case 183:
          return listGen(298, 2);
        case 184:
          return listGen(300, 1);
        case 185:
          return listGen(301, 1);
        case 186:
          return listGen(302, 1);
        case 187:
          return listGen(303, 1);
        case 188:
          return listGen(304, 2);
        case 189:
          return listGen(306, 1);
        case 190:
          return listGen(307, 2);
        case 191:
          return listGen(309, 3);
        case 192:
          return listGen(312, 1);
        case 193:
          return listGen(313, 1);
        case 194:
          return listGen(314, 1);
        case 195:
          return listGen(315, 1);
        case 196:
          return listGen(316, 2);
        case 197:
          return listGen(318, 2);
        case 198:
          return listGen(320, 2);
        case 199:
          return listGen(322, 2);
        case 200:
          return listGen(324, 2);
        case 201:
          return listGen(326, 1);
        case 202:
          return listGen(327, 2);
        case 203:
          return listGen(329, 3);
        case 204:
          return listGen(332, 1);
        case 205:
          return listGen(333, 2);
        case 206:
          return listGen(335, 2);
        case 207:
          return listGen(337, 1);
        case 208:
          return listGen(338, 2);
        case 209:
          return listGen(340, 1);
        case 210:
          return listGen(341, 1);
        case 211:
          return listGen(342, 1);
        case 212:
          return listGen(343, 1);
        case 213:
          return listGen(344, 1);
        case 214:
          return listGen(345, 2);
        case 215:
          return listGen(347, 2);
        case 216:
          return listGen(349, 1);
        case 217:
          return listGen(350, 1);
        case 218:
          return listGen(351, 2);
        case 219:
          return listGen(353, 2);
        case 220:
          return listGen(355, 2);
        case 221:
          return listGen(357, 2);
        case 222:
          return listGen(359, 1);
        case 223:
          return listGen(360, 1);
        case 224:
          return listGen(361, 2);
        case 225:
          return listGen(363, 1);
        case 226:
          return listGen(364, 1);
        case 227:
          return listGen(365, 1);
        case 228:
          return listGen(366, 1);
        case 229:
          return listGen(367, 2);
        case 230:
          return listGen(369, 3);
        case 231:
          return listGen(372, 1);
        case 232:
          return listGen(373, 2);
        case 233:
          return listGen(375, 1);
        case 234:
          return listGen(376, 1);
        case 235:
          return listGen(377, 1);
        case 236:
          return listGen(378, 1);
        case 237:
          return listGen(379, 2);
        case 238:
          return listGen(381, 2);
        case 239:
          return listGen(383, 1);
        case 240:
          return listGen(384, 1);
        case 241:
          return listGen(385, 2);
        case 242:
          return listGen(387, 1);
        case 243:
          return listGen(388, 1);
        case 244:
          return listGen(389, 1);
        case 245:
          return listGen(390, 1);
        case 246:
          return listGen(391, 2);
        case 247:
          return listGen(393, 2);
        case 248:
          return listGen(395, 1);
        case 249:
          return listGen(396, 1);
        case 250:
          return listGen(397, 1);
        case 251:
          return listGen(398, 2);
        case 252:
          return listGen(400, 1);
        case 253:
          return listGen(401, 1);
        case 254:
          return listGen(402, 2);
        case 255:
          return listGen(404, 3);
        case 256:
          return listGen(407, 2);
        case 257:
          return listGen(409, 1);
        case 258:
          return listGen(410, 1); //c
        case 259:
          return listGen(411, 3);
        case 260:
          return listGen(414, 2);
        case 261:
          return listGen(416, 2); //c
        case 262:
          return listGen(418, 2);
        case 263:
          return listGen(420, 2);
        case 264:
          return listGen(422, 2);
        case 265:
          return listGen(424, 4);
        case 266:
          return listGen(428, 2);
        case 267:
          return listGen(430, 3);
        case 268:
          return listGen(433, 2);
        case 269:
          return listGen(435, 1);
        case 270:
          return listGen(436, 1);
        case 271:
          return listGen(437, 1); //c
        case 272:
          return listGen(438, 1);
        case 273:
          return listGen(439, 2);
        case 274:
          return listGen(441, 2);
        case 275:
          return listGen(444, 1);
        case 276:
          return listGen(445, 1);
        case 277:
          return listGen(446, 1);
        case 278:
          return listGen(447, 1);
        case 279:
          return listGen(448, 2);
        case 280:
          return listGen(450, 2);
        case 281:
          return listGen(452, 1);
        case 282:
          return listGen(453, 2);
        case 283:
          return listGen(455, 1);
        case 284:
          return listGen(456, 1);
        case 285:
          return listGen(457, 1);
        case 286:
          return listGen(458, 2);
        case 287:
          return listGen(460, 2);
        case 288:
          return listGen(462, 1); //c
        case 289:
          return listGen(463, 1);
        case 290:
          return listGen(464, 1);
        case 291:
          return listGen(465, 1);
        case 292:
          return listGen(466, 1);
        case 293:
          return listGen(467, 1);
        case 294:
          return listGen(468, 2);
        case 295:
          return listGen(470, 2);
        case 296:
          return listGen(472, 1);
        case 297:
          return listGen(473, 1);
        case 298:
          return listGen(474, 1);
        case 299:
          return listGen(475, 1);
        case 300:
          return listGen(476, 1);
        case 301:
          return listGen(477, 1);
        case 302:
          return listGen(478, 1);
        case 303:
          return listGen(479, 1);
        case 304:
          return listGen(480, 1);
        case 305:
          return listGen(482, 1);
        case 306:
          return listGen(483, 1);
        case 307:
          return listGen(484, 1);
        case 308:
          return listGen(485, 3);
        case 309:
          return listGen(488, 1);
        case 310:
          return listGen(489, 1);
        case 311:
          return listGen(490, 1);
        case 312:
          return listGen(491, 2);
        case 313:
          return listGen(494, 1);
        case 314:
          return listGen(495, 2);
        case 315:
          return listGen(497, 2);
        case 316:
          return listGen(499, 1);
        case 317:
          return listGen(500, 1);
        case 318:
          return listGen(501, 1);
        case 319:
          return listGen(502, 1);
        case 320:
          return listGen(503, 1);
        case 321:
          return listGen(504, 1);
        case 322:
          return listGen(505, 2);
        case 323:
          return listGen(507, 1); //c
        case 324:
          return listGen(508, 1);
        case 325:
          return listGen(509, 1);
        case 326:
          return listGen(510, 2); //c
        case 327:
          return listGen(512, 1);
        case 328:
          return listGen(513, 2);
        case 329:
          return listGen(515, 1);
        case 330:
          return listGen(516, 1);
        case 331:
          return listGen(517, 1);
        case 332:
          return listGen(518, 2);
        case 333:
          return listGen(520, 2);
        case 334:
          return listGen(522, 2);
        case 335:
          return listGen(524, 2);
        case 336:
          return listGen(526, 1);
        case 337:
          return listGen(527, 2); //c
        case 338:
          return listGen(529, 2);
        case 339:
          return listGen(531, 2);
        case 340:
          return listGen(533, 2);
        case 341:
          return listGen(535, 3);
        case 342:
          return listGen(538, 6);
        case 343:
          return listGen(544, 1);
        case 344:
          return listGen(545, 5);
        case 345:
          return listGen(550, 1);
        case 346:
          return listGen(551, 1);
        case 347:
          return listGen(552, 1);
        case 348:
          return listGen(553, 1);
        case 349:
          return listGen(554, 1);
        case 350:
          return listGen(555, 2);
        case 351:
          return listGen(557, 2);
        case 352:
          return listGen(559, 2);
        case 353:
          return listGen(561, 1);
        case 354:
          return listGen(562, 2);
        case 355:
          return listGen(564, 1);
        case 356:
          return listGen(565, 2);
        case 357:
          return listGen(567, 4);
        case 358:
          return listGen(571, 2); //c
        case 359:
          return listGen(573, 1);
        case 360:
          return listGen(574, 1);
        case 361:
          return listGen(575, 1);
        case 362:
          return listGen(576, 1); //c
        case 363:
          return listGen(577, 1);
        case 364:
          return listGen(578, 1);
        case 365:
          return listGen(579, 2);
        case 366:
          return listGen(581, 1); //c
        case 367:
          return listGen(582, 2); //c
        case 368:
          return listGen(584, 2);
        case 369:
          return listGen(586, 1);
        case 370:
          return listGen(587, 1);
        case 371:
          return listGen(588, 1);
        case 372:
          return listGen(589, 1);
        case 373:
          return listGen(590, 1);
        case 374:
          return listGen(591, 1);
        case 375:
          return listGen(592, 2);
        case 376:
          return listGen(594, 1);
        case 377:
          return listGen(595, 1);
        case 378:
          return listGen(596, 1);
        case 379:
          return listGen(597, 1);
        case 380:
          return listGen(598, 2);
        case 381:
          return listGen(600, 1);
        case 382:
          return listGen(601, 1);
        case 383:
          return listGen(602, 1);
        case 384:
          return listGen(603, 1);
        case 385:
          return listGen(604, 1);
        case 386:
          return listGen(605, 1);
        case 387:
          return listGen(606, 1); //c
        case 388:
          return listGen(607, 3);
        case 389:
          return listGen(610, 1);
        case 390:
          return listGen(611, 1);
        case 391:
          return listGen(612, 1);
        case 392:
          return listGen(613, 1);
        case 393:
          return listGen(614, 3);
        case 394:
          return listGen(617, 1);
        case 395:
          return listGen(618, 1);
        case 396:
          return listGen(619, 1);
        case 397:
          return listGen(620, 1);
        case 398:
          return listGen(621, 2);
        case 399:
          return listGen(623, 2);
        case 400:
          return listGen(625, 2);
        case 401:
          return listGen(627, 1);
        case 402:
          return listGen(628, 1);
        case 403:
          return listGen(629, 2); //c
        case 404:
          return listGen(631, 1);
        case 405:
          return listGen(632, 1);
        case 406:
          return listGen(633, 2); //c
        case 407:
          return listGen(635, 1);
        case 408:
          return listGen(636, 2);
        case 409:
          return listGen(638, 2);
        case 410:
          return listGen(640, 2); //c
        case 411:
          return listGen(642, 1);
        case 412:
          return listGen(643, 1);
        case 413:
          return listGen(644, 1);
        case 414:
          return listGen(645, 2);
        case 415:
          return listGen(647, 2);
        case 416:
          return listGen(649, 3);
        case 417:
          return listGen(652, 1);
        case 418:
          return listGen(653, 2);
        case 419:
          return listGen(655, 1);
        case 420:
          return listGen(656, 1);
        case 421:
          return listGen(657, 1);
        case 422:
          return listGen(658, 2);
        case 423:
          return listGen(660, 1);
        case 424:
          return listGen(661, 1);
        case 425:
          return listGen(662, 1);
        case 426:
          return listGen(663, 1);
        case 427:
          return listGen(664, 1);
        case 428:
          return listGen(665, 1);
        case 429:
          return listGen(666, 2);
        case 430:
          return listGen(668, 1);
        case 431:
          return listGen(669, 1);
        case 432:
          return listGen(670, 2);
        case 433:
          return listGen(672, 2);
        case 434:
          return listGen(674, 1);
        case 435:
          return listGen(675, 2);
        case 436:
          return listGen(677, 1);
        case 437:
          return listGen(678, 2);
        case 438:
          return listGen(680, 2);
        case 439:
          return listGen(682, 2);
        case 440:
          return listGen(684, 1);
        case 441:
          return listGen(685, 2);
        case 442:
          return listGen(687, 2);
        case 443:
          return listGen(689, 3);
        case 444:
          return listGen(692, 2);
        case 445:
          return listGen(694, 2); //c
        case 446:
          return listGen(696, 1);
        case 447:
          return listGen(697, 1);
        case 448:
          return listGen(698, 1);
        case 449:
          return listGen(699, 2);
        case 450:
          return listGen(701, 1);
        case 451:
          return listGen(702, 1);
        case 452:
          return listGen(703, 2);
        case 453:
          return listGen(705, 1);
        case 454:
          return listGen(706, 1); //c
        case 455:
          return listGen(707, 1);
        case 456:
          return listGen(708, 1);
        case 457:
          return listGen(709, 1);
        case 458:
          return listGen(710, 1);
        case 459:
          return listGen(711, 2);
        case 460:
          return listGen(713, 1);
        case 461:
          return listGen(714, 2);
        case 462:
          return listGen(716, 1);
        default:
          return List.empty();
      }
    case Buch.jugendliederbuch:
      switch (nummer) {
        case 1:
          return listGen(1, 3);
        case 2:
          return listGen(4, 3);
        case 3:
          return listGen(7, 2);
        case 4:
          return listGen(9, 1);
        case 5:
          return listGen(10, 1);
        case 6:
          return listGen(11, 3);
        case 7:
          return listGen(14, 4);
        case 8:
          return listGen(18, 1);
        case 9:
          return listGen(19, 2);
        case 10:
          return listGen(21, 2);
        case 11:
          return listGen(23, 4);
        case 12:
          return listGen(27, 2);
        case 13:
          return listGen(29, 2);
        case 14:
          return listGen(31, 2);
        case 15:
          return listGen(33, 2);
        case 16:
          return listGen(35, 2);
        case 17:
          return listGen(37, 2);
        case 18:
          return listGen(39, 4);
        case 19:
          return listGen(43, 1);
        case 20:
          return listGen(44, 2);
        case 21:
          return listGen(46, 2);
        case 22:
          return listGen(48, 6);
        case 23:
          return listGen(54, 3);
        case 24:
          return listGen(57, 2);
        case 25:
          return listGen(59, 2);
        case 26:
          return listGen(61, 1);
        case 27:
          return listGen(62, 2);
        case 28:
          return listGen(64, 5);
        case 29:
          return listGen(69, 4);
        case 30:
          return listGen(73, 2);
        case 31:
          return listGen(75, 8);
        case 32:
          return listGen(83, 3);
        case 33:
          return listGen(86, 2);
        case 34:
          return listGen(88, 1);
        case 35:
          return listGen(89, 1);
        case 36:
          return listGen(90, 1);
        case 37:
          return listGen(91, 1);
        case 38:
          return listGen(92, 3);
        case 39:
          return listGen(95, 2);
        case 40:
          return listGen(97, 1);
        case 41:
          return listGen(98, 2);
        case 42:
          return listGen(100, 2);
        case 43:
          return listGen(102, 4);
        case 44:
          return listGen(106, 3);
        case 45:
          return listGen(109, 1);
        case 46:
          return listGen(110, 2);
        case 47:
          return listGen(112, 1);
        case 48:
          return listGen(113, 1);
        case 49:
          return listGen(114, 1);
        case 50:
          return listGen(115, 3);
        case 51:
          return listGen(118, 2);
        case 52:
          return listGen(120, 2);
        case 53:
          return listGen(122, 1);
        case 54:
          return listGen(123, 1);
        case 55:
          return listGen(124, 3);
        case 56:
          return listGen(127, 1);
        case 57:
          return listGen(128, 2);
        case 58:
          return listGen(130, 2);
        case 59:
          return listGen(132, 3);
        case 60:
          return listGen(135, 1);
        case 61:
          return listGen(136, 2);
        case 62:
          return listGen(138, 3);
        case 63:
          return listGen(141, 2);
        case 64:
          return listGen(143, 2);
        case 65:
          return listGen(145, 1);
        case 66:
          return listGen(146, 3);
        case 67:
          return listGen(149, 1);
        case 68:
          return listGen(150, 2);
        case 69:
          return listGen(152, 2);
        case 70:
          return listGen(154, 1);
        case 71:
          return listGen(155, 2);
        case 72:
          return listGen(157, 3);
        case 73:
          return listGen(160, 2);
        case 74:
          return listGen(162, 2);
        case 75:
          return listGen(164, 2);
        case 76:
          return listGen(166, 2);
        case 77:
          return listGen(168, 2);
        case 78:
          return listGen(170, 4);
        case 79:
          return listGen(174, 2);
        case 80:
          return listGen(176, 2);
        case 81:
          return listGen(178, 1);
        case 82:
          return listGen(179, 2);
        case 83:
          return listGen(181, 2);
        case 84:
          return listGen(183, 1);
        case 85:
          return listGen(184, 1);
        case 86:
          return listGen(185, 2);
        case 87:
          return listGen(187, 1);
        case 88:
          return listGen(188, 1);
        case 89:
          return listGen(189, 2);
        case 90:
          return listGen(191, 2);
        case 91:
          return listGen(193, 1);
        case 92:
          return listGen(194, 1);
        case 93:
          return listGen(195, 2);
        case 94:
          return listGen(197, 2);
        case 95:
          return listGen(199, 2);
        case 96:
          return listGen(201, 5);
        case 97:
          return listGen(206, 3);
        case 98:
          return listGen(209, 2);
        case 99:
          return listGen(211, 2);
        case 100:
          return listGen(213, 2);
        case 101:
          return listGen(215, 4);
        case 102:
          return listGen(219, 1);
        default:
          return List.empty();
      }
    case Buch.jbergaenzungsheft:
      switch (nummer) {
        case 1:
          return listGen(0, 1);
        case 2:
          return listGen(1, 2);
        case 3:
          return listGen(3, 2);
        case 4:
          return listGen(5, 1);
        case 5:
          return listGen(6, 1);
        case 6:
          return listGen(7, 2);
        case 7:
          return listGen(9, 2);
        case 8:
          return listGen(11, 2);
        case 9:
          return listGen(13, 1);
        case 10:
          return listGen(14, 1);
        case 11:
          return listGen(15, 2);
        case 12:
          return listGen(17, 2);
        case 13:
          return listGen(19, 2);
        case 14:
          return listGen(21, 4);
        case 15:
          return listGen(25, 4);
        case 16:
          return listGen(29, 3);
        case 17:
          return listGen(32, 3);
        case 18:
          return listGen(35, 3);
        case 19:
          return listGen(38, 3);
        case 20:
          return listGen(41, 3);
        default:
          return List.empty();
      }
    default:
      return List.empty();
  }
}
