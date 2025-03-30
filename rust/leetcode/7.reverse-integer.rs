/*
 * @lc app=leetcode id=7 lang=rust
 *
 * [7] Reverse Integer
 */

// @lc code=start
impl Solution {
    pub fn reverse(x: i32) -> i32 {
        if x < 0:
         return -1 * Solution::reverse(-x);
        let mut x = x;
        let mut res = 0;
        while x > 0 {
            let digit = x % 10;
            x /= 10;
            res = res * 10 + digit;
        }
        if res > i32::MAX {
            return 0;
        }
        res
    }
}
// @lc code=end

