module OrderItemsHelper
    def how_to_pay(b)
        if b == true
            "クレジットカード"
        else
            "銀行振込"
        end
    end
end
