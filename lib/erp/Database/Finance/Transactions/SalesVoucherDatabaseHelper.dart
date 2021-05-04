import 'package:authentication_with_bloc/erp/DataModels/Masters/Inventory/CompoundItemDataModel.dart';
import 'package:authentication_with_bloc/erp/DataModels/Masters/Inventory/InventoryItemDataModel.dart';
import 'package:authentication_with_bloc/erp/DataModels/Transactions/GeneralVoucherDataModel.dart';
import 'package:authentication_with_bloc/erp/Database/DatabaseHelper.dart';
import 'package:authentication_with_bloc/erp/Database/core/TransactionDBAbstract.dart';
import 'package:authentication_with_bloc/erp/DataModels/Masters/UOM/UOMDataModel.dart';

const String Sales_Invoice_Main_TableName = "Sales_Invoice_Main";

const String col_Sales_Invoice_Main_id = "_id";
const String col_Sales_Invoice_Main_Voucher_No = "Voucher_No";
const String col_Sales_Invoice_Main_Voucher_Prefix = "Voucher_Prefix";
const String col_Sales_Invoice_Main_Date_Created = "Date_Created";
const String col_Sales_Invoice_Main_Voucher_Date = "Voucher_Date";
const String col_Sales_Invoice_Main_TimeStamp = "`TimeStamp`";
const String col_Sales_Invoice_Main_TimeStampC = "TimeStamp";

const String col_Sales_Invoice_Main_Last_Updated = "Last_Updated";
const String col_Sales_Invoice_Main_Ledger_ID = "Ledger_ID";
const String col_Sales_Invoice_Main_Billing_Name = "Billing_Name";
const String col_Sales_Invoice_Main_Total = "Total";
const String col_Sales_Invoice_Main_Narration = "Narration";
const String col_Sales_Invoice_Main_Added_By = "Added_By";
const String col_Sales_Invoice_Main_Delivery_Date = "Delivery_Date";
const String col_Sales_Invoice_Main_Completion_Probability =
    "Completion_Probability";
const String col_Sales_Invoice_Main_Credit_Period = "Credit_Period";
const String col_Sales_Invoice_Main_POC_Name = "POC_Name";
const String col_Sales_Invoice_Main_POC_Phone = "POC_Phone";
const String col_Sales_Invoice_Main_POC_Email = "POC_Email";
const String col_Sales_Invoice_Main_Project_ID = "Project_ID";
const String col_Sales_Invoice_Main_Revision_Number = "Revision_Number";
const String col_Sales_Invoice_Main_Converted_To_Sales_Order =
    "Converted_To_Sales_Order";
const String col_Sales_Invoice_Main_Quotation_Dropped = "Quotation_Dropped";
const String col_Sales_Invoice_Main_Quotation_Dropped_Reason =
    "Quotation_Dropped_Reason";
const String col_Sales_Invoice_Main_Requirement_Voucher_No =
    "Requirement_Voucher_No";
const String col_Sales_Invoice_Main_Salesman_ID = "Salesman_ID";
const String col_Sales_Invoice_Main_LPORef = "LPO_Ref";
const String col_Sales_Invoice_Main_ModeOfService = "MODE_OF_SERVICE";
const String col_Sales_Invoice_Main_Discount_In_Amount = "Discount_In_Amount";
const String col_Sales_Invoice_Main_Discount_In_Percent = "Discount_In_Percent";
const String col_Sales_Invoice_Main_VATAmount = "VAT_Amount";
const String col_Sales_Invoice_Main_VoucherStatus = "VoucherStatus";
const String col_Sales_Invoice_Main_Contact_ID = "ContactID";
const String col_Sales_Invoice_Main_Gross_Total = "Gross_Total";
const String col_Sales_Invoice_Main_Reference = "Reference";
const String col_Sales_Invoice_Main_Customer_Expecting_Date =
    "Customer_Expected_Date";
const String col_Sales_Invoice_Main_Currency = "Currency";
const String col_Sales_Invoice_Main_BoxesCount = "Boxes_Count";
const String col_Sales_Invoice_Main_TotalWeight = "Total_Weight";
const String col_Sales_Invoice_Main_LRNo = "LR_No";
const String col_Sales_Invoice_Main_VoucherNoDisplay = "Voucher_No_Display";
const String col_Sales_Invoice_Main_ReqVoucherList = "Requirement_Voucher_List";
const String col_Sales_Invoice_Main_Origin = "Origin";
const String col_Sales_Invoice_Main_Round_Off = "Round_Off";
const String col_Sales_Invoice_Main_GeneratedTransactionId = "TransactionId";
const String col_Sales_Invoice_Main_PaymentSplit = "PaymentSplit";

const String Sales_Invoice_Details_TableName = "Sales_Invoice_Details";

const String col_Sales_Invoice_Details_id = "_id";
const String col_Sales_Invoice_Details_Voucher_No = "Voucher_No";
const String col_Sales_Invoice_Details_Voucher_Prefix = "Voucher_Prefix";
const String col_Sales_Invoice_Details_Voucher_Date = "Voucher_Date";
const String col_Sales_Invoice_Details_Inventory_Item_ID = "Inventory_Item_ID";
const String col_Sales_Invoice_Details_Quantity = "Quantity";
const String col_Sales_Invoice_Details_Price = "Price";
const String col_Sales_Invoice_Details_PriceLevel = "PriceLevel";
const String col_Sales_Invoice_Details_isCompoundItem = "isCompoundItem";
const String col_Sales_Invoice_Details_subItemOff_list_ID =
    "subItemOff_list_ID";
const String col_Sales_Invoice_Details_Discount_Percent = "Discount_Percent";
const String col_Sales_Invoice_Details_Discount_Amount = "Discount_Amount";
const String col_Sales_Invoice_Details_Subtotal = "Subtotal";
const String col_Sales_Invoice_Details_Project_ID = "Project_ID";
const String col_Sales_Invoice_Details_Item_Narration = "Item_Narration";
const String col_Sales_Invoice_Details_Item_Description = "Item_Description";
const String col_Sales_Invoice_Details_Salesman_ID = "Salesman_ID";
const String col_Sales_Invoice_Details_Requirement_ItemID =
    "Requirement_ItemID";
const String col_Sales_Invoice_Details_Length = "Length";
const String col_Sales_Invoice_Details_Time = "Time";
const String col_Sales_Invoice_Details_UomId = "Uom_Id";
const String col_Sales_Invoice_Details_Dimension = "Dimension";
const String col_Sales_Invoice_Details_itemVoucherStatus = "itemVoucherStatus";
const String col_Sales_Invoice_Details_itemProductionStatus =
    "itemProductionStatus";
const String col_Sales_Invoice_Details_TaxRate = "Tax_Rate";
const String col_Sales_Invoice_Details_TaxAmount = "Tax_Amount";
const String VoucherType = "SALESVOUCHER";

class SalesVoucherDBHelper extends TransactionDBAbstract {
  static final DatabaseHelper _db = DatabaseHelper.get();

  SalesVoucherDBHelper()
      : super(
            col_Sales_Invoice_Main_Voucher_Date,
            col_Sales_Invoice_Main_Voucher_No,
            col_Sales_Invoice_Main_Billing_Name,
            col_Sales_Invoice_Main_Total,
            '',
            Sales_Invoice_Main_TableName,
            Sales_Invoice_Details_TableName,
            col_Sales_Invoice_Main_Voucher_No,
            col_Sales_Invoice_Main_Voucher_Prefix,
            VoucherType,
            _db);

  @override
  Future<bool> deleteVoucher(String voucherNo, String voucherPrefix) async {
    return super.deleteVoucher(voucherNo, voucherPrefix);
  }

  @override
  Future<bool> upsertVoucher(GeneralVoucherDataModel voucher) async {
    /* TODO :
  1. Get Voucher NO
  2. Set or update UUID
  3. Transaction Helper
  4. Transaction item Helper
  5. Other Table Inserts if any.  
*/
    Map map = new Map();

    map[col_Sales_Invoice_Main_Voucher_No] = voucher.voucherNumber;
    map[col_Sales_Invoice_Main_Voucher_Prefix] = voucher.voucherPrefix;
    map[col_Sales_Invoice_Main_Date_Created] = voucher.voucherDate;
    map[col_Sales_Invoice_Main_Voucher_Date] = voucher.voucherDate;
    map[col_Sales_Invoice_Main_Ledger_ID] = voucher.ledgerObject.LedgerID;
    map[col_Sales_Invoice_Main_Billing_Name] = voucher.ledgerObject.LedgerName;
    map[col_Sales_Invoice_Main_Total] = voucher.grandTotal;
    map[col_Sales_Invoice_Main_Narration] = voucher.narration;
    map[col_Sales_Invoice_Main_Added_By] = voucher.AddedBy;
    map[col_Sales_Invoice_Main_Delivery_Date] = voucher.DeliveryDate;
    map[col_Sales_Invoice_Main_Completion_Probability] =
        voucher.CompletionProbability;
    map[col_Sales_Invoice_Main_Credit_Period] =
        voucher.ledgerObject.creditPeriod;
    map[col_Sales_Invoice_Main_POC_Name] =
        voucher.ledgerObject.ContactPersonName;
    map[col_Sales_Invoice_Main_POC_Phone] = voucher.Contact.PhoneNumber;
    map[col_Sales_Invoice_Main_POC_Email] =
        voucher.ledgerObject.ContactPersonEmail;
    map[col_Sales_Invoice_Main_Project_ID] = voucher.ProjectId;
    map[col_Sales_Invoice_Main_Revision_Number] = voucher.RevisionNo;
    map[col_Sales_Invoice_Main_Converted_To_Sales_Order] =
        voucher.ConvertedToSalesOrder;
    map[col_Sales_Invoice_Main_Quotation_Dropped] = voucher.QuotationDropped;
    map[col_Sales_Invoice_Main_Quotation_Dropped_Reason] =
        voucher.QuotationDroppedReason;
    map[col_Sales_Invoice_Main_Requirement_Voucher_No] =
        voucher.RequirementVoucherNo;

    map[col_Sales_Invoice_Main_Salesman_ID] = voucher.SalesmanID;
    map[col_Sales_Invoice_Main_ModeOfService] = voucher.ModeOfService;
    map[col_Sales_Invoice_Main_Contact_ID] = voucher.Contact._id;
    map[col_Sales_Invoice_Main_VATAmount] = voucher.taxTotalAmount;
    map[col_Sales_Invoice_Main_VoucherStatus] = voucher.status;
    map[col_Sales_Invoice_Main_Discount_In_Amount] = voucher.discountinAmount;
    map[col_Sales_Invoice_Main_Discount_In_Percent] = voucher.discountPercent;
    map[col_Sales_Invoice_Main_Gross_Total] = voucher.grossTotal;
    map[col_Sales_Invoice_Main_Reference] = voucher.reference;
    map[col_Sales_Invoice_Main_Round_Off] = voucher.roundOff;
    map[col_Sales_Invoice_Main_LPORef] = voucher.LPO;
    map[col_Sales_Invoice_Main_GeneratedTransactionId] = voucher.TransactionId;
    map[col_Sales_Invoice_Main_PaymentSplit] = voucher.paymentSplit;
    map[col_Sales_Invoice_Main_Last_Updated] = DateTime.now();

    _db.startTransaction();
    if (!await exists(voucher.voucherNumber, voucher.voucherPrefix)) {
      // Insert
      map[col_Sales_Invoice_Main_TimeStampC] = DateTime.now();
    } else {
      // Update
      map[col_Sales_Invoice_Main_TimeStampC] = voucher.timestamp;

      //Delete DETAILS TABLE
      Map _clauseMap = Map();
      _clauseMap[voucherNoColumn] = voucher.voucherNumber;
      _clauseMap[voucherPrefixColumn] = voucher.voucherPrefix;
      await _db.deleteRecords(tablename: detailsTableName, clause: _clauseMap);
      //DELETE TRANSACTION HELPER
      //DELETE TRANSACTION ITEM HELPER;
      _db.updateRecords(
          tablename: mainTableName, data: map, clause: _clauseMap);
    }

    for (CompoundItemDataModel comp in voucher.InventoryItems) {
      InventoryItemDataModel item = comp.BaseItem;
      Map map1 = Map();
      map1[col_Sales_Invoice_Details_Requirement_ItemID] = item.ItemReqUuid;
      map1[col_Sales_Invoice_Details_Voucher_No] = voucher.voucherNumber;
      map1[col_Sales_Invoice_Details_Voucher_Prefix] = voucher.voucherPrefix;
      map1[col_Sales_Invoice_Details_Voucher_Date] = voucher.voucherDate;
      map1[col_Sales_Invoice_Details_Inventory_Item_ID] = item.itemID;
      map1[col_Sales_Invoice_Details_Quantity] = item.quantity;
      map1[col_Sales_Invoice_Details_Price] = item.price;
      map1[col_Sales_Invoice_Details_PriceLevel] = item.PriceLevel;
      map1[col_Sales_Invoice_Details_isCompoundItem] = item.isCompoundItem;
      map1[col_Sales_Invoice_Details_subItemOff_list_ID] = 0;
      map1[col_Sales_Invoice_Details_Discount_Percent] =
          item.discountPercentage;
      map1[col_Sales_Invoice_Details_Discount_Amount] = item.discountinAmount;
      map1[col_Sales_Invoice_Details_Subtotal] = item.subTotal;
      map1[col_Sales_Invoice_Details_Project_ID] = voucher.ProjectId;
      map1[col_Sales_Invoice_Details_Item_Narration] = item.narration;
      map1[col_Sales_Invoice_Details_Item_Description] = item.itemDescription;
      map1[col_Sales_Invoice_Details_Salesman_ID] = voucher.SalesmanID;
//map1[col_Sales_Invoice_Details_Requirement_ItemID] = item.requirementItemIdOld;
      map1[col_Sales_Invoice_Details_Requirement_ItemID] = item.ItemReqUuid;
      map1[col_Sales_Invoice_Details_TaxRate] = item.taxRate;
      map1[col_Sales_Invoice_Details_TaxAmount] = item.taxAmount;
      map1[col_Sales_Invoice_Details_Length] = item.length;
      map1[col_Sales_Invoice_Details_Time] = DateTime.now() as String;
      map1[col_Sales_Invoice_Details_UomId] = item.uomObject.id;

      await _db.insertRecords(data: map1, tablename: detailsTableName);
    }

    // Insert to transaction _helper;
    // Insert to transaction_item_helper;

    return _db.commitTransaction();
  }

  @override
  Future<GeneralVoucherDataModel> getVoucherByVoucherNo(
      String voucherNo, String voucherPrefix) async {
    String qStrMain = "SELECT ";
    String qStrDetails = "SELECT ";
    String qStrLedgers = "SELECT ";

    qStrMain = "SELECT ";
    qStrMain += col_Sales_Invoice_Main_Voucher_No + ", ";
    qStrMain += col_Sales_Invoice_Main_Voucher_Prefix + ", ";
    qStrMain += col_Sales_Invoice_Main_Date_Created + ", ";
    qStrMain += col_Sales_Invoice_Main_Voucher_Date + ", ";
    qStrMain += col_Sales_Invoice_Main_TimeStamp + ", ";
    qStrMain += col_Sales_Invoice_Main_Ledger_ID + ", ";
    qStrMain += col_Sales_Invoice_Main_Billing_Name + ", ";
    qStrMain += col_Sales_Invoice_Main_Total + ", ";
    qStrMain += col_Sales_Invoice_Main_Narration + ", ";
    qStrMain += col_Sales_Invoice_Main_Added_By + ", ";
    qStrMain += col_Sales_Invoice_Main_Delivery_Date + ", ";
    qStrMain += col_Sales_Invoice_Main_Completion_Probability + ", ";
    qStrMain += col_Sales_Invoice_Main_Credit_Period + ", ";
    qStrMain += col_Sales_Invoice_Main_POC_Name + ", ";
    qStrMain += col_Sales_Invoice_Main_POC_Phone + ", ";
    qStrMain += col_Sales_Invoice_Main_POC_Email + ", ";
    qStrMain += col_Sales_Invoice_Main_Project_ID + ", ";
    qStrMain += col_Sales_Invoice_Main_Revision_Number + ", ";
    qStrMain += col_Sales_Invoice_Main_Converted_To_Sales_Order + ", ";
    qStrMain += col_Sales_Invoice_Main_Quotation_Dropped + ", ";
    qStrMain += col_Sales_Invoice_Main_Quotation_Dropped_Reason + ", ";
    qStrMain += col_Sales_Invoice_Main_Requirement_Voucher_No + ", ";
    qStrMain += col_Sales_Invoice_Main_Salesman_ID + ", ";
    qStrMain += col_Sales_Invoice_Main_LPORef + ", ";
    qStrMain += col_Sales_Invoice_Main_VoucherStatus + ", ";
    qStrMain += col_Sales_Invoice_Main_ModeOfService + ", ";
    qStrMain += col_Sales_Invoice_Main_Discount_In_Amount + ", ";
    qStrMain += col_Sales_Invoice_Main_Discount_In_Percent + ", ";
    qStrMain += col_Sales_Invoice_Main_VATAmount + ", ";
    qStrMain += col_Sales_Invoice_Main_Contact_ID + ", ";
    qStrMain += col_Sales_Invoice_Main_Gross_Total + ", ";
    qStrMain += col_Sales_Invoice_Main_Reference + ", ";
    qStrMain += col_Sales_Invoice_Main_Customer_Expecting_Date + ", ";
    qStrMain += col_Sales_Invoice_Main_Currency + ", ";
    qStrMain += col_Sales_Invoice_Main_BoxesCount + ", ";
    qStrMain += col_Sales_Invoice_Main_TotalWeight + ", ";
    qStrMain += col_Sales_Invoice_Main_LRNo + ", ";
    qStrMain += col_Sales_Invoice_Main_VoucherNoDisplay + ", ";
    qStrMain += col_Sales_Invoice_Main_ReqVoucherList + ", ";
    qStrMain += col_Sales_Invoice_Main_Origin + ", ";
    qStrMain += col_Sales_Invoice_Main_GeneratedTransactionId + ", ";
    qStrMain += col_Sales_Invoice_Main_PaymentSplit;
    qStrMain += " FROM " + Sales_Invoice_Main_TableName;
    qStrMain += " WHERE ";
    qStrMain += "$voucherNoColumn = ? AND ";
    qStrMain += "$voucherPrefixColumn = ? ";

    qStrDetails = uom_subquery;
  }
}
