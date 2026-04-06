-- Example: Ticket/Order Reporting Dashboard Query
SELECT 
    t.ticket_id,
    t.summary,
    b.board_name,
    s.status_name,
    o.order_number
FROM tickets t
LEFT JOIN boards b ON t.board_id = b.id
LEFT JOIN status s ON t.status_id = s.id
LEFT JOIN orders o ON t.ticket_id = o.ticket_id
WHERE s.status_name <> 'Closed'
ORDER BY t.ticket_id DESC;
