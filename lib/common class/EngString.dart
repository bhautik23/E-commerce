// ignore_for_file: non_constant_identifier_names, file_names

class Engstring {
  // latitude

  static double latitude = 0.0;
  static double longitude = 0.0;
  static bool locationpermission = false;
  //MARK: Login Screen

//   static String Login = "Login";
//   static String Signin_to_your_account = "Sign in to your account";
//   static String Email = "Email";
//   static String Password = "Password";
//   static String Forgot_Password = "Forgot Password?";

//   static String OR = "-----  OR  -----";
//   static String Dont_have_an_account = "Don't have an account";
//   static String Signup = "Signup";
//   static String Skip_continue = "Skip & Continue";
//   static String Please_enter_valid_email_address =
//       "Please enter valid email address";
//   static String Please_enter_all_details = "Please enter all details";

//   //MARK: Register Screen
//   static String
//       Create_an_account_so_you_can_order_your_favourite_product_faster =
//       "Create an Account so you can order your favorite food even faster";
//   static String Full_name = "Full Name";
//   static String Mobile = "Mobile";
//   static String Referral_code_Optional = "Referral code (Optional)";
//   static String I_accept_the_terms_conditions = "I accept tearms & conditions";
//   static String Already_have_an_account = "Already have an account";
//   static String Please_select_terms_conditions =
//       "Please accept terms & conditions";

//   //MARK: Teams & Conditions screen
//   static String TeamsConditions = "Teams and Conditions";

//   // MARK: Forgot Password Screen
//   static String Forgot_Password_ = "Forgot Password";
//   static String
//       Enter_your_registered_email_address_below_We_will_send_new_password_in_your_email =
//       "Enter your registered email address below. We will send new password in your email.";
//   static String Submit = "Submit";

//   //MARK: Email Verify Screen
//   static String OTP_Verification = "OTP Verification";
//   static String Check_your_email_for_OTP_Enter_OTP_below_and_proceed_further =
//       "Check your email for OTP. Enter OTP below and proceed further.";
//   static String Enter_OTP_here = "Enter OTP here";
//   static String Verify_Proceed = "Verify & Proceed";
//   static String Dont_receive_an_OTP = "Don't receive an OTP?";
//   static String Resend_OTP = "Resend OTP";

//   //MARK: Home Screen
//   static String Restaurant_User = "Restaurant User";
//   static String Welcome = "Welcome,";
//   static String Search_Here = "Search Here..";
//   static String Categories = "Categories";
//   static String Trending = "Trending";
//   static String Todays_special = "Today's Special";
//   static String Recommended = "Recommended";
//   static String Testimonials = "Testimonials";
//   static String ADD = "ADD";
//   static String
//       The_item_has_multtiple_customizations_added_Go_to_cart__to_remove_item =
//       "The item has multtiple customizations added. Go to cart to remove item";
//   static String GO_TO_CART = "GO TO CART";
//   static String CANCEL = "CANCEL";

//   //MARK: Product Detail Screen
//   static String additional_tax = "additional tax";
//   static String Inclusive_of_all_taxes = "Inclusive of all taxes";
//   static String Description = "Description";
//   static String Add_ons = "Add-ons";
//   static String Related_roducts = "Related Products";
//   static String Add_to_cart = "Add to cart";
//   static String Viewcart = "View cart";

//   //MARK: Filter Screen
//   static String Filter_Options = "Filter Options";
//   static String Veg = "Veg";
//   static String Nonveg = "Non-veg";
//   static String Both = "Both";

//   //MARK: Search Screen

//   static String Search = "Search";
//   static String No_data_found = "No data found";

//   //MARK: Favorite List Screen
//   static String Favorite_list = "Favorite List";

//   //MARK: Cart Screen
//   static String Mycart = "My Cart";
//   static String Continue = "Continue";
//   static String Select_Option = "Select Option";
//   static String DELIVERY = "DELIVERY";
//   static String Checkout = "Check Out";
//   static String Takeaway = "TAKE AWAY";
//   static String Cancel = "Cancel";
//   static String Please_select_option = "Please select option";
//   static String
//       Youve_reached_the_maximum_units_allowedfor_the_purchase_of_this_item =
//       "You've reached the maximum units allowed for the purchase of this item";
//   static String Restaurant_is_closed_Try_after_some_time =
//       "Restaurant is closed. Try after some time";

//   //MARK: Order Summary Screen
//   static String Order_Summary = "Order Summary";
//   static String Product_Summary = "Product Summary";
//   static String Qty = "Qty:";
//   static String Promocode = "Promocode";
//   static String Selectpromo = "Select promocode";
//   static String haveapromocode = "Have a Promocode?";
//   static String Apply = "Apply";
//   static String Remove = "Remove";
//   static String Bill_Details = "Bill Details";
//   static String Item_Total = "Item Total";
//   static String Tax = "Tax";
//   static String Delivery_Fee = "Delivery Fee";
//   static String Discount_Offer = "Discount Offer";
//   static String Total_pay = "Total Pay";
//   static String Deliveryaddress = "Delivery address";
//   static String SELECT = "SELECT";
//   static String Set_your_delivery_address = "Set your delivery address";
//   static String Please_select_delivery_address =
//       "Please select delivery address";
//   static String Special_instructions = "Special instructions";
//   static String Write_order_instructions = "Write order instructions";
//   static String Process_to_pay = "Process To Pay";
//   static String You_are_not_eligeble_for_this_offer =
//       "You are not eligeble for this offer";
//   static String Order_amount_must_be_between = "Order amount must be between";

//   // //MARK: Payment Options Screen
//   static String Payment_Option = "Payment Option";
//   static String Place_Order = "Place order";
//   static String Please_select_payment_option = "Please select payment option";
//   static String
//       You_dont_have_sufficient_wallet_amonut_Please_select_another_payment_option =
//       "You don't have sufficient wallet amonut. Please select another payment option";

//   //MARK: Order Success Screen
//   static String Success = "Success";
//   static String
//       Your_order_has_been_placed_successfully_will_be_process_by_system =
//       "Your order has been successfully placed & will be process by system.";
//   static String Check_Order_Details = "Check Order Details";

//   //MARK: My Orders Screen
//   static String My_Orders = "My Orders";
//   static String Processing = "Processing";
//   static String Completed = "Completed";
//   static String Cancelled = "Cancelled";
//   static String Cash = "Cash";
//   static String Wallet = "Wallet";
//   static String RazorPay = "RazorPay";
//   static String Stripepay = "Stripe";
//   static String Flutterwave = "Flutterwave";
//   static String Paystack = "Paystack";
//   static String Delivery = "Delivery";
//   static String Take_away = "Take away";
//   static String Paymenttype = "Payment Type : ";
//   static String Placed = "Placed";
//   static String Preparing = "Preparing";
//   static String Ready = "Ready";
//   static String On_the_way = "On the way";
//   static String Waiting_for_pickup = "Waiting for pickup";

// //MARK: Order Details Screen
//   static String Order_Details = "Order Details";
//   static String Cancel_Order = "Cancel Order";
//   static String Driver_information = "Driver information";
//   static String
//       Are_you_sure_to_cancel_this_order_If_yes_then_order_amount_Online_payment_OR_Wallet_payment_will_be_transferred_to_your_wallet =
//       "Are you sure to cancel this order? If yes, then order amount (Online payment OR Wallet payment) will be transferred to your wallet.";

//   //MARK: My Profile Screen
//   static String Myprofile = "My Profile";
//   static String Settings = "Settings";
//   static String Change_Password = "Change Password";
//   static String My_Addresses = "My Addresses";
//   static String My_Wallet = "My Wallet";
//   static String Refer_Earn = "Refer & Earn";
//   static String Notification_Settings = "Notification Settings";
//   static String Change_Layout = "Change Layout";
//   static String Help_Contact_Us = "Help & Contact Us";
//   static String Privacy_Policy = "Privacy Policy";
//   static String About_Us = "About Us";
//   static String FAQs = "FAQs";
//   static String Gallery = "Gallery";
//   static String Book_A_Table = "Book A Table";
//   static String Blogs = "Blogs";
//   static String Our_Team = "Our Team";
//   static String Logout = "Logout";
//   static String Select_application_layout = "Select Application Layout";
//   static String LTR = "LTR";
//   static String RTL = "RTL";
//   static String Are_you_sure_to_logout_from_this_app =
//       "Are you sure to logout from this app?";

//   //MARK: Edit Profile Screen
//   static String Edit_Profile = "Edit Profile";
//   static String Save = "Save";
//   static String Select_image = "Select image";
//   static String Photo_library = "Photo library";
//   static String Camera = "Camera";

//   //MARK: Change Password Screen
//   static String Old_password = "Old Password";
//   static String New_password = "New Password";
//   static String Confirm_password = "Confirm Password";
//   static String Reset = "Reset";
//   static String New_password_Confirm_password_must_be_same =
//       "New password & Confirm password must be same";

//   //MARK: My Addresses Screen
//   static String Home = "Home";
//   static String Office = "Office";
//   static String Other = "Other";
//   static String Add_New_Address = "Add New Address";
//   static String Are_you_sure_to_delete_this_address =
//       "Are you sure to delete this address?";
//   static String Yes = "Yes";
//   static String No = "No";

//   // MARK: Add Address Screen
//   static String Add_Address = "Add Address";
//   static String Edit_Address = "Edit Address";
//   static String Selectdelloca = "SELECT DELIVERY LOCATION";
//   static String Change = "Change";
//   static String Confirmlocation = "Confirm location";

//   //MARK: Confirm Address Screen
//   static String Confirm_Address = "Confirm Address";
//   static String
//       A_detailed_address_will_help_our_delivery_parnter_reach_your_doorstep_easily =
//       "A detailed address will help our Delivery Parnter reach your doorstep easily";
//   static String Complete_address = "Complete Address";
//   static String House_flate_Floorno = "House / flat / Floor No.";
//   static String Apartment_Road_Area_Optional =
//       "Apartment / Road / Area (optional)";
//   static String saveas = "Save As";
//   static String HOME = "HOME";
//   static String OFFICE = "OFFICE";
//   static String OTHER = "OTHER";
//   static String Saveaddressdetails = "SAVE ADDRESS DETAILS";

//   // MARK: My Wallet Screen
//   static String Wallet_Money = "WALLET MONEY";
//   static String Fast_Easy_Payments = "Fast & Easy Payments";
//   static String Secure_Payments = "Secure Payments";
//   static String No_Document_Upload_Required = "No Document Upload Required";
//   static String Total_Balance = "Total Balance";
//   static String WALLET_MONEY_Can_only_be_used_for_your_orders =
//       "*WALLET MONEY can only be used for your food orders";
//   static String ADD_MONEY = "+ ADD MONEY";

//   // MARK: Add Money Screen

//   static String Add_Money = "Add Money";
//   static String Enteramount = "ENTER AMOUNT";
//   static String Procaddmoney = "PROCEED TO ADD MONEY";
//   static String Total_Balance_ = "Total Balance :";
//   static String NOTES = "NOTES :";

//   static String Wallet_Money_cannot_be_transferred_to_your_bank_account =
//       "-> WALLET Money Cannot Be Transferred to your Bank Account.";
//   static String You_can_use_Wallet_Money_only_on_orders =
//       "-> You can use Wallet Money only on Restaurant orders";
//   static String Please_enter_amount = "Please enter amount";

//   // MARK: Transaction History Screen
//   static String Transaction_History = "Transaction History";
//   static String Wallet_Order = "Wallet Order";
//   static String Order_Cancel = "Order Cancelled";
//   static String Order_Id = "Order id : ";
//   static String Wallet_Recharge = "Wallet Recharge";
//   static String Referral_Amount = "Referral Amount";

//   // MARK: Add Testimonial Screen
//   static String Add_Testimonial = "Add Testimonial";
//   static String Enteryoureview = "Enter your review";

//   // MARK: Refer & Earn Screen
//   static String Share = "SHARE";
//   static String
//       Share_this_code_with_a_friend_and_you_both_could_be_eligible_for =
//       "Share this code with a friend and you both could be eligible for \$30.00 bonus amount under our Referral Program.";
//   static String bonus_amount_under_our_referral_program =
//       "bonus amount under our referral program.";
//   static String Use_this_code = "Use this code";
//   static String to_register_with = "to register with";
//   static String get_bonus_amount = "& get bonus amount";

// // MARK: Notification Settings Screen
//   static String Push_Notifications = "Push Notifications";
//   static String keepthisonnoti =
//       "keep this on to receive notifications from system";
//   static String Emails = "Emails";
//   static String Keep_this_on_to_receive_emails_from_system =
//       "keep this on to receive email from system";

//   // MARK: Help & Contact Us Screen
//   static String Contact_Us = "Contact Us";
//   static String Inquiry_form = "Inquiry Form";
//   static String First_name = "First Name";
//   static String Last_name = "Last Name";
//   static String Message = "Message";

//   // MARK: Book A Table Screen

//   static String No_of_guest = "No. of guest";
//   static String Date = "Date";
//   static String Time = "Time";
//   static String Reservation_Type = "Reservation Type";
//   static String Special_Request_Optional = "Special Request(Optional)";
//   static String Your_booking_request_is_registered_successfully =
//       "Your booking request is registered successfully";

//   // Blogs screen
//   static String Posted_by = "Posted by :";

//   // Blogs details screen
//   static String Blogs_details = "Blogs Details";

//   // MARK: Date Picker Screen
//   static String Done = "Done";

//   // MARK: Card info Screen
//   static String Card_information = "Card information";
//   static String Card_number = "Card number";
//   static String Card_holder_name = "Card holder name";
//   static String MM = "MM";
//   static String YYYY = "YYYY";
//   static String CVV = "CVV";

//   // extra
//   static String Gravityinfotech = "Gravity Infotech";
//   static String Infotechgravitygmail = "Infotechgravity@gmail.com";
//   static String Darkmode = "Dark Mode";
//   static String Name = "Name";
//   static String Phoneno = "Phone No";
//   static String Myadresses = "My Adresses";
//   static String Compaddress = "Complete Address";
//   static String Houseflate = "House / flat / Floor No.";
//   static String Apartmentroad = "Apartment / Road / Area (optional)";
//   static String Instrefund = "Instant Refunds";
//   static String Devbygravityinfo = "Develpoed by Gravity Infotech";
//   static String Zero = "00";
//   static String Payment = "Payment";
//   static String Contectus = "Contect Us";
//   static String No91_70164 = "+91 7016428845";
//   static String Company_address = "Green Road, Uttran, Surat, Gujarat, India";
//   static String Ordersummary = "Order Summary";
//   static String Productsummary = "Product Summary";
//   static String Select = "SELECT";
//   static String Onlyforyou = "ONLY FOR YOU";
//   static String Ratingreview = "Ratings & Reviews";
//   static String Faqs = "Faqs";
//   static String Reservationtype = "Reservation Type";
//   static String Specialrequest = "Special Request(Optional)";
}
