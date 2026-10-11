SELECT 
payment_type,
CASE 
    When payments.payment_installments = 1 Then '1 installment'
    When payments.payment_installments In (2, 3, 4, 5) Then '2 - 5 installments'
    When payments.payment_installments In (6,7,8,9,10) Then '6 - 10 installments'
    Else '11+ installments'
END AS installment_range,
COUNT(*) AS installment_count
From payments
WHERE payments.payment_type = 'credit_card' AND payments.payment_installments != 0 AND payments.payment_installments IS NOT NULL
Group BY installment_range, payment_type
ORDER BY installment_count DESC;


