#lang heresy

(def fn collatz (n)
  (select
   ((one? n) '(1))
   ((even? n) (join n (collatz (/ n 2))))
   ((odd? n) (join n (collatz (+ (* 3 n) 1))))))

(def fn coll-count (n)
  (let recur ([x n]
              [c 0])
    (select
     ((one? x) `(,n ,c))
     ((even? x)
      (recur (/ x 2) (inc c)))
     (else (recur (+ (* 3 x) 1) (inc c))))))

(for (x in (range 2 to 999999) with '(1 1))
  (let ([y (coll-count x)])
    (if (> (head (tail y))
           (head (tail cry)))
     then
        (carry y)
     else
        (carry cry))))
