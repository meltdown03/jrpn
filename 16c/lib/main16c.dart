/*
Copyright (c) 2021,2022 William Foote

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 3 of the License, or (at your option) any later
version.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

You should have received a copy of the GNU General Public License along with
this program; if not, see https://www.gnu.org/licenses/ .
*/

import 'package:jrpn/c/controller.dart';
import 'package:jrpn/c/operations.dart';
import 'package:jrpn/generic_main.dart';
import 'package:jrpn/m/model.dart';
import 'package:jrpn/v/buttons.dart';

import 'tests16c.dart';

void main() async => genericMain(Jrpn(Controller16(Model16())));


class Model16 extends Model<Operation> {

  @override
  List<List<MKey<Operation>?>> get logicalKeys => _logicalKeys;

  //
  // See Model.logicalKeys.  This table determines the operation opcodes.
  // Changing the order here would render old JSON files of the
  // calculator's state obsolete.
  static final List<List<MKey<Operation>?>> _logicalKeys = [
    [
      MKey(Operations.a, Operations.sl, Operations.lj),
      MKey(Operations.b, Operations.sr, Operations.asr),
      MKey(Operations.c, Operations.rl, Operations.rlc),
      MKey(Operations.d, Operations.rr, Operations.rrc),
      MKey(Operations.e, Operations.rln, Operations.rlcn),
      MKey(Operations.f, Operations.rrn, Operations.rrcn),
      MKey(Operations.n7, Operations.maskl, Operations.poundB),
      MKey(Operations.n8, Operations.maskr, Operations.abs),
      MKey(Operations.n9, Operations.rmd, Operations.dblr),
      MKey(Operations.div, Operations.xor, Operations.dblDiv),
    ],
    [
      MKey(Operations.gsb, Operations.xSwapParenI, Operations.rtn),
      MKey(Operations.gto, Operations.xSwapI, Operations.lbl),
      MKey(Operations.hex, Operations.showHex, Operations.dsz),
      MKey(Operations.dec, Operations.showDec, Operations.isz),
      MKey(Operations.oct, Operations.showOct, Operations.sqrtOp),
      MKey(Operations.bin, Operations.showBin, Operations.reciprocal),
      MKey(Operations.n4, Operations.sb, Operations.sf),
      MKey(Operations.n5, Operations.cb, Operations.cf),
      MKey(Operations.n6, Operations.bQuestion, Operations.fQuestion),
      MKey(Operations.mult, Operations.and, Operations.dblx),
    ],
    [
      MKey(Operations.rs, Operations.parenI, Operations.pr),
      MKey(Operations.sst, Operations.I, Operations.bst),
      MKey(Operations.rDown, Operations.clearPrgm, Operations.rUp),
      MKey(Operations.xy, Operations.clearReg, Operations.pse),
      MKey(Operations.bsp, Operations.clearPrefix, Operations.clx),
      MKey(Operations.enter, Operations.window, Operations.lstx),
      MKey(Operations.n1, Operations.onesCompl, Operations.xLEy),
      MKey(Operations.n2, Operations.twosCompl, Operations.xLT0),
      MKey(Operations.n3, Operations.unsign, Operations.xGTy),
      MKey(Operations.minus, Operations.not, Operations.xGT0),
    ],
    [
      MKey(Operations.onOff, Operations.onOff, Operations.onOff),
      MKey(Operations.fShift, Operations.fShift, Operations.fShift),
      MKey(Operations.gShift, Operations.gShift, Operations.gShift),
      MKey(Operations.sto, Operations.wSize, Operations.windowRight),
      MKey(Operations.rcl, Operations.floatKey, Operations.windowLeft),
      null,
      MKey(Operations.n0, Operations.mem, Operations.xNEy),
      MKey(Operations.dot, Operations.status, Operations.xNE0),
      MKey(Operations.chs, Operations.eex, Operations.xEQy),
      MKey(Operations.plus, Operations.or, Operations.xEQ0),
    ]
  ];


  @override
  bool get displayLeadingZeros => getFlag(3);
  @override
  bool get cFlag => getFlag(4);
  @override
  set cFlag(bool v) => setFlag(4, v);
  @override
  bool get gFlag => getFlag(5);
  @override
  set gFlag(bool v) => setFlag(5, v);

}

///
/// The layout of the buttons (part of the view, but retrieved by the
/// controller as part of initialization).
///
class ButtonLayout16 extends ButtonLayout {
  final ButtonFactory factory;
  final double _totalButtonHeight;
  final double _buttonHeight;

  ButtonLayout16(this.factory, this._totalButtonHeight, this._buttonHeight);

  CalculatorButton get a => CalculatorButtonWithLJ(factory, 'A', 'SL',
      'L\u200AJ', Operations.a, Operations.sl, Operations.lj, 'A');
  CalculatorButton get b => CalculatorButton(factory, 'B', 'SR', 'ASR',
      Operations.b, Operations.sr, Operations.asr, 'B');
  CalculatorButton get c => CalculatorButton(factory, 'C', 'RL', 'RLC',
      Operations.c, Operations.rl, Operations.rlc, 'C');
  CalculatorButton get d => CalculatorButton(factory, 'D', 'RR', 'RRC',
      Operations.d, Operations.rr, Operations.rrc, 'D');
  CalculatorButton get e => CalculatorButton(factory, 'E', 'RLn', 'RLCn',
      Operations.e, Operations.rln, Operations.rlcn, 'E');
  CalculatorButton get f => CalculatorButton(factory, 'F', 'RRn', 'RRCn',
      Operations.f, Operations.rrn, Operations.rrcn, 'F');
  CalculatorButton get n7 => CalculatorButton(factory, '7', 'MASKL', '#B',
      Operations.n7, Operations.maskl, Operations.poundB, '7');
  CalculatorButton get n8 => CalculatorButton(factory, '8', 'MASKR', 'ABS',
      Operations.n8, Operations.maskr, Operations.abs, '8');
  CalculatorButton get n9 => CalculatorButton(factory, '9', 'RMD', 'DBLR',
      Operations.n9, Operations.rmd, Operations.dblr, '9');
  CalculatorButton get div => CalculatorButton(factory, '\u00F7', 'XOR',
      'DBL\u00F7', Operations.div, Operations.xor, Operations.dblDiv, '/');

  CalculatorButton get gsb => CalculatorButton(factory, 'GSB', 'x\u2B0C(i)',
      'RTN', Operations.gsb, Operations.xSwapParenI, Operations.rtn, 'U');
  CalculatorButton get gto => CalculatorButton(factory, 'GTO', 'x\u2B0CI',
      'LBL', Operations.gto, Operations.xSwapI, Operations.lbl, 'T');
  CalculatorButton get hex => CalculatorButton(factory, 'HEX', '', 'DSZ',
      Operations.hex, Operations.showHex, Operations.dsz, 'I');
  CalculatorButton get dec => CalculatorButton(factory, 'DEC', '', 'ISZ',
      Operations.dec, Operations.showDec, Operations.isz, 'Z');
  CalculatorButton get oct => CalculatorSqrtButton(factory, 'OCT', '',
      '\u221Ax', Operations.oct, Operations.showOct, Operations.sqrtOp, 'K');
  CalculatorButton get bin => CalculatorButton(factory, 'BIN', '', '1/x',
      Operations.bin, Operations.showBin, Operations.reciprocal, 'L');
  CalculatorButton get n4 => CalculatorButton(factory, '4', 'SB', 'SF',
      Operations.n4, Operations.sb, Operations.sf, '4');
  CalculatorButton get n5 => CalculatorButton(factory, '5', 'CB', 'CF',
      Operations.n5, Operations.cb, Operations.cf, '5');
  CalculatorButton get n6 => CalculatorButton(factory, '6', 'B?', 'F?',
      Operations.n6, Operations.bQuestion, Operations.fQuestion, '6');
  CalculatorButton get mult => CalculatorOnSpecialButton(
      factory,
      '\u00D7',
      'AND',
      'DBLx',
      Operations.mult,
      Operations.and,
      Operations.dblx,
      'X*',
      'TST',
      acceleratorLabel: '*\u00d7');
  CalculatorButton get rs => CalculatorButton(factory, 'R/S', '(i)', 'P/R',
      Operations.rs, Operations.parenI, Operations.pr, '[');
  CalculatorButton get sst => CalculatorButton(factory, 'SST', 'I', 'BST',
      Operations.sst, Operations.I, Operations.bst, ']');
  CalculatorButton get rdown => CalculatorButton(factory, 'R\u2193', 'PRGM',
      'R\u2191', Operations.rDown, Operations.clearPrgm, Operations.rUp, 'V');
  CalculatorButton get xy => CalculatorButton(factory, 'x\u2B0Cy', 'REG', 'PSE',
      Operations.xy, Operations.clearReg, Operations.pse, 'Y');
  CalculatorButton get bsp => CalculatorButton(
      factory,
      'BSP',
      'PREFIX',
      'CLx',
      Operations.bsp,
      Operations.clearPrefix,
      Operations.clx,
      '\u0008\u007f\uf728',
      acceleratorLabel: '\u2190');
  @override
  CalculatorButton get enter => CalculatorEnterButton(
      factory,
      'E\nN\nT\nE\nR',
      'WINDOW',
      'LSTx',
      Operations.enter,
      Operations.window,
      Operations.lstx,
      '\n\r',
      extraHeight: factory.height * _totalButtonHeight / _buttonHeight,
      acceleratorLabel: ' \u23ce');
  CalculatorButton get n1 => CalculatorButton(factory, '1', '1\'s', 'x\u2264y',
      Operations.n1, Operations.onesCompl, Operations.xLEy, '1');
  CalculatorButton get n2 => CalculatorButton(factory, '2', '2\'s', 'x<0',
      Operations.n2, Operations.twosCompl, Operations.xLT0, '2');
  CalculatorButton get n3 => CalculatorButton(factory, '3', 'UNSGN', 'x>y',
      Operations.n3, Operations.unsign, Operations.xGTy, '3');
  CalculatorButton get minus => CalculatorOnSpecialButton(
      factory,
      '\u2212',
      'NOT',
      'x>0',
      Operations.minus,
      Operations.not,
      Operations.xGT0,
      '-',
      'CLR',
      acceleratorLabel: '\u2212');

  CalculatorButton get onOff => CalculatorOnButton(factory, 'ON', '', '',
      Operations.onOff, Operations.onOff, Operations.onOff, 'O', 'OFF');
  CalculatorButton get fShift => CalculatorFButton(factory, 'f', '', '',
      Operations.fShift, Operations.fShift, Operations.fShift, 'M\u0006',
      acceleratorLabel: 'M');
  CalculatorButton get gShift => CalculatorGButton(factory, 'g', '', '',
      Operations.gShift, Operations.gShift, Operations.gShift, 'G\u0007',
      acceleratorLabel: 'G');
  CalculatorButton get sto => CalculatorButton(factory, 'STO', 'WSIZE', '<',
      Operations.sto, Operations.wSize, Operations.windowRight, 'S<');
  CalculatorButton get rcl => CalculatorButton(factory, 'RCL', 'FLOAT', '>',
      Operations.rcl, Operations.floatKey, Operations.windowLeft, 'R>');
  CalculatorButton get n0 => CalculatorButton(factory, '0', 'MEM', 'x\u2260y',
      Operations.n0, Operations.mem, Operations.xNEy, '0');
  CalculatorButton get dot => CalculatorOnSpecialButton(
      factory,
      '\u2219',
      'STATUS',
      'x\u22600',
      Operations.dot,
      Operations.status,
      Operations.xNE0,
      '.',
      '\u2219/\u201a',
      acceleratorLabel: '\u2219');
  CalculatorButton get chs => CalculatorButton(factory, 'CHS', 'EEX', 'x=y',
      Operations.chs, Operations.eex, Operations.xEQy, 'H');
  CalculatorButton get plus => CalculatorButton(factory, '+', 'OR', 'x=0',
      Operations.plus, Operations.or, Operations.xEQ0, '+=');

  @override
  List<List<CalculatorButton?>> get landscapeLayout => [
    [a, b, c, d, e, f, n7, n8, n9, div],
    [gsb, gto, hex, dec, oct, bin, n4, n5, n6, mult],
    [rs, sst, rdown, xy, bsp, null, n1, n2, n3, minus],
    [onOff, fShift, gShift, sto, rcl, null, n0, dot, chs, plus]
  ];

  @override
  List<List<CalculatorButton?>> get portraitLayout => [
    [onOff, rdown, xy, bsp, fShift, gShift],
    [gsb, gto, hex, dec, oct, bin],
    [a, b, c, d, e, f],
    [rs, sst, n7, n8, n9, div],
    [sto, rcl, n4, n5, n6, mult],
    [null, null, n1, n2, n3, minus],
    [null, null, n0, dot, chs, plus],
  ];
}

class Controller16 extends RealController {

  Controller16(Model<Operation> model) : super(model);

  @override
  SelfTests newSelfTests({bool inCalculator = true}) =>
    SelfTests16(inCalculator: inCalculator);

  @override
  ButtonLayout getButtonLayout(ButtonFactory factory, double totalHeight,
      double totalButtonHeight) => ButtonLayout16(factory, totalHeight, totalButtonHeight);
}