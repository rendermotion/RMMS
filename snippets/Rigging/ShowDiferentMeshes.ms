rollout ddl_test "Drop-Down List"

(
	

 dropdownlist scale_dd "Scale" items:#("1/2", "1/4", "1/8", "1/16")

on scale_dd selected i do

 format "You selected '%'!\n" scale_dd.items[i]

)

createDialog ddl_test


