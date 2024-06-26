import 'package:flutter/material.dart';
import 'package:promissorynotemanager/data/history_data.dart';
import 'package:google_fonts/google_fonts.dart'; // Add google_fonts package
import 'package:intl/intl.dart';

import 'package:share_plus/share_plus.dart';

class HistoryPopUp {
  void _shareNoteDetails(HistoryData noteData) async {
    final textToShare = "Note Details:\n\n"
        "Principal Amount: ₹${noteData.principalAmount}\n"
        "Interest Rate: ${noteData.interestRate / 12 * 100}Rs\n"
        "From Date: ${DateFormat('dd/MM/yyyy').format(noteData.fromDate)}\n"
        "Till Date: ${DateFormat('dd/MM/yyyy').format(noteData.tillDate)}\n"
        "Duration: ${noteData.duration}\n"
        "Interest Earned: ₹${noteData.interestEarned.toStringAsFixed(2)}\n"
        "Total Amount: ₹${noteData.totalAmount.toStringAsFixed(2)}";

    // Optionally, share a screenshot of the page (you'll need to implement this separately)
    // ...
    await Share.share(
        textToShare); // Use Share.share to initiate sharing dialog
  }

  void showHistoryDialog(BuildContext context, HistoryData historyData) {
    final formattedFromDate =
        DateFormat('dd MMM yyyy').format(historyData.fromDate);
    final formattedTillDate =
        DateFormat('dd MMM yyyy').format(historyData.tillDate);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          // Use a Dialog for custom styling
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Calculation Details',
                  style: GoogleFonts.montserrat(
                    // Use Montserrat font
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildDetailRow(
                    'Principal Amount:', '₹${historyData.principalAmount}'),
                _buildDetailRow('Interest Rate:',
                    '${historyData.interestRate / 12 * 100}Rs'),
                _buildDetailRow('From Date:', formattedFromDate),
                _buildDetailRow('Till Date:', formattedTillDate),
                _buildDetailRow('Duration:', historyData.duration),
                _buildDetailRow('Interest Earned:',
                    '₹${historyData.interestEarned.toStringAsFixed(2)}'),
                const SizedBox(height: 10),
                const Divider(), // Visual separation
                _buildDetailRow('Total Amount:',
                    '₹${historyData.totalAmount.toStringAsFixed(2)}',
                    isTotal: true),
                const SizedBox(height: 20),
                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        FocusScope.of(context).unfocus();
                      },
                      child: Text('Close',
                          style: GoogleFonts.lato(
                              color: Colors.grey)), // Lato font for buttons
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _shareNoteDetails(historyData);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Custom button color
                      ),
                      child: Text('Share',
                          style: GoogleFonts.lato(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      FocusScope.of(context).unfocus();
    });
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.lato(
              fontWeight: FontWeight.bold, // Make label bold
            ),
          ),
          Text(
            value,
            style: GoogleFonts.lato(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
