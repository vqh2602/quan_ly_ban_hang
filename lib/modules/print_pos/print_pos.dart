import 'package:flutter/foundation.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:quan_ly_ban_hang/data/models/customer.dart';
import 'package:quan_ly_ban_hang/data/models/sales_order.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_sales_invoice/detail_sales_invoice_controller.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/library/esc_pos_print/flutter_esc_pos_network.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class NetworkPrinter {
  Future<List<int>> testTicket() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];

    bytes += generator.text(
        'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
        styles: const PosStyles(codeTable: 'CP1252'));
    bytes += generator.text('Special 2: blåbærgrød',
        styles: const PosStyles(codeTable: 'CP1252'));

    bytes += generator.text('Bold text', styles: const PosStyles(bold: true));
    bytes +=
        generator.text('Reverse text', styles: const PosStyles(reverse: true));
    bytes += generator.text('Underlined text',
        styles: const PosStyles(underline: true), linesAfter: 1);
    bytes += generator.text('Align left',
        styles: const PosStyles(align: PosAlign.left));
    bytes += generator.text('Align center',
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text('Align right',
        styles: const PosStyles(align: PosAlign.right), linesAfter: 1);

    bytes += generator.row([
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col6',
        width: 6,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
    ]);

    bytes += generator.text('Text size 200%',
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    // Print barcode
    final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    bytes += generator.barcode(Barcode.upcA(barData));

    bytes += generator.feed(2);
    bytes += generator.cut();
    return bytes;
  }

  Future<void> printTicket(List<int> ticket) async {
    final printer = PrinterNetworkManager(
        'ipp://vqh.local.:8632/ipp/print/roll',
        timeout: const Duration(seconds: 30));
    PosPrintResult connect = await printer.connect();
    if (connect == PosPrintResult.success) {
      PosPrintResult printing = await printer.printTicket(ticket);

      if (kDebugMode) {
        print(printing.msg);
      }
      printer.disconnect();
    }
  }
}

class NativePrinter {
  final doc = pw.Document();
  createDoc({
    SalesOrder? salesOrder,
    List<DetailSalesOrderCustom>? detailSalesOrderCustom,
    Customer? customer,
    num? discount,
    num? vat,
  }) async {
    final font = await PdfGoogleFonts.robotoSlabMedium();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('DIEN MAY HOANG MAI',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                font: font,
                                fontSize: 17)),
                        pw.Text('HOA DON BAN HANG',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                font: font,
                                fontSize: 17)),
                      ]),
                  pw.SizedBox(height: 12),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Expanded(
                          child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                    'Dia chi: So 9, ngo 1 pho Hung Phuc, Yen So, Hoang Mai, HN',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      font: font,
                                    )),
                                pw.Text('So dien thoai: 0988062120',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      font: font,
                                    )),
                              ]),
                        ),
                        pw.SizedBox(width: 30),
                        pw.Text(
                            'CUA HANG DIEN MAY HOANG MAI\nCAM KET 100% CHINH HANG!',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              font: font,
                              fontWeight: pw.FontWeight.bold,
                            )),
                      ]),
                  pw.SizedBox(height: 12),
                  pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Khach hang: ${salesOrder?.customerName ?? ''}',
                            style: pw.TextStyle(
                              font: font,
                            )),
                        pw.Text('Ma khach hang: ${customer?.name ?? ''}',
                            style: pw.TextStyle(
                              font: font,
                            )),
                      ]),
                  pw.SizedBox(height: 12),
                  pw.Center(
                    child: pw.Text('SAN PHAM',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: font,
                          fontWeight: pw.FontWeight.bold,
                        )),
                  ),
                  pw.Table(children: [
                    pw.TableRow(children: [
                      pw.Text('Ten san pham',
                          style: pw.TextStyle(
                            font: font,
                          )),
                      pw.Text('So luong',
                          style: pw.TextStyle(
                            font: font,
                          )),
                      pw.Text('Don gia',
                          style: pw.TextStyle(
                            font: font,
                          )),
                      pw.Text('Thanh tien',
                          style: pw.TextStyle(
                            font: font,
                          )),
                    ]),
                    for (DetailSalesOrderCustom item
                        in detailSalesOrderCustom ?? [])
                      pw.TableRow(children: [
                        pw.Text(item.product?.name ?? '',
                            style: pw.TextStyle(
                              font: font,
                            )),
                        pw.Text('${item.detailSalesOrder?.quantity}',
                            style: pw.TextStyle(
                              font: font,
                            )),
                        pw.Text(
                            ShareFuntion.formatCurrency(
                                item.detailSalesOrder!.price!,
                                symbol: 'VND'),
                            style: pw.TextStyle(
                              font: font,
                            )),
                        pw.Text(
                            ShareFuntion.formatCurrency(
                                item.detailSalesOrder!.quantity! *
                                    item.detailSalesOrder!.price!,
                                symbol: 'VND'),
                            style: pw.TextStyle(
                              font: font,
                            )),
                      ])
                  ]),
                  pw.Divider(),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('TONG TIEN',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              fontSize: 20,
                              font: font,
                              fontWeight: pw.FontWeight.bold,
                            )),
                        pw.Text(
                            ShareFuntion.formatCurrency(
                                salesOrder!.totalMoney ?? 0,
                                symbol: 'VND'),
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              fontSize: 20,
                              font: font,
                              fontWeight: pw.FontWeight.bold,
                            )),
                      ]),
                  pw.Divider(),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Giam gia: ',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              font: font,
                            )),
                        pw.Text('${salesOrder.discount}%',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              font: font,
                            )),
                      ]),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Phu phi: ',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              font: font,
                            )),
                        pw.Text(
                            ShareFuntion.formatCurrency(
                                salesOrder.partlyPaid ?? 0,
                                symbol: 'VND'),
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              font: font,
                            )),
                      ]),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('VAT: ',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              font: font,
                            )),
                        pw.Text('${salesOrder.vat}%',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              font: font,
                            )),
                      ]),
                  pw.Divider(),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Tien mat: ',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              font: font,
                            )),
                        pw.Text(
                            ShareFuntion.formatCurrency(
                                salesOrder.moneyGuests ?? 0,
                                symbol: 'VND'),
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              font: font,
                            )),
                      ]),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Tien thoi lai: ',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              font: font,
                            )),
                        pw.Text(
                            ShareFuntion.formatCurrency(
                                salesOrder.changeMoney ?? 0,
                                symbol: 'VND'),
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              font: font,
                            )),
                      ]),
                  pw.Divider(),
                  pw.Row(children: [
                    pw.Text('Thu ngan: ',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: font,
                        )),
                    pw.Text(
                        '${salesOrder.personnelSalespersonName!} - ${salesOrder.personnelSalespersonId!}',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: font,
                        )),
                  ]),
                  pw.Row(children: [
                    pw.Text('Ticket: ',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: font,
                        )),
                    pw.Text(salesOrder.uid ?? '',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: font,
                        )),
                  ]),
                  pw.Row(children: [
                    pw.Text('Thoi gian xuat: ',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: font,
                        )),
                    pw.Text(DateTime.now().toString(),
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: font,
                        )),
                  ]),
                  pw.Divider(),
                  pw.Center(
                    child: pw.Text('Cam on quy khach !\nHen gap lai !',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: font,
                          fontWeight: pw.FontWeight.bold,
                        )),
                  ),
                ]),
          ); // Center
        })); // Page
  }

  nativePrint({
    SalesOrder? salesOrder,
    List<DetailSalesOrderCustom>? detailSalesOrderCustom,
    Customer? customer,
  }) async {
    await createDoc(
        salesOrder: salesOrder,
        detailSalesOrderCustom: detailSalesOrderCustom,
        customer: customer);
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  sharePrint() async {
    await Printing.sharePdf(
        bytes: await doc.save(), filename: 'my-document.pdf');
  }
}
