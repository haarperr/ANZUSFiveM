local Translations = {
  error = {
    no_deposit = "$%{value} deposit required",
    cancelled = "Cancelled",
    vehicle_not_correct = "This is not a commercial vehicle!",
    no_driver = "You must be the driver to do this..",
    no_work_done = "You haven't done any work yet..",
    backdoors_not_open = "The backdoors of the vehicle aren't open",
    get_out_vehicle = "You need to step out of the vehicle to perform this action",
    too_far_from_trunk = "You need to grab the boxes from the trunk of your vehicle",
    too_far_from_delivery = "You need to be closer to the delivery point"
  },
  success = {
    paid_with_cash = "$%{value} Deposit paid with cash",
    paid_with_bank = "$%{value} Deposit Paid from bank",
    refund_to_cash = "$%{value} Deposit Paid with cash",
    you_earned = "You earned $%{value}",
    payslip_time = "You have delivered everywhere, time to get your payslip!",
  },
  menu = {
    header = "Available Trucks",
    close_menu = "⬅ Close Menu",
  },
  mission = {
    store_reached = "Store reached, you should check the back for a box",
    take_box = "Grab a box of products",
    deliver_box = "Deliver box",
    another_box = "Grab another box",
    goto_next_point = "Time to head to the next delivery point",
    return_to_station = "You have delivered everywhere, head back to the warehouse",
    job_completed = "You have completed your route, time to get your payslip!"
  },
  info = {
    deliver_e = "~g~E~w~ - Deliver",
    deliver = "Deliver",
  }
}

Lang = Locale:new({
  phrases = Translations,
  warnOnMissing = true
})
