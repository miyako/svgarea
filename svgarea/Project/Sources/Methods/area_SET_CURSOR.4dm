//%attributes = {"invisible":true}
#DECLARE($object : Text)

Case of 
	: ($object="") || ($object="horizontalLine") || ($object="verticalLine")
		SET CURSOR:C469
	: ($object="handle_tl@")
		SET CURSOR:C469(9005)
		
	: ($object="handle_tm@")
		SET CURSOR:C469(9004)
		
	: ($object="handle_tr@")
		SET CURSOR:C469(9006)
		
	: ($object="handle_mr@")
		SET CURSOR:C469(9003)
		
	: ($object="handle_br@")
		SET CURSOR:C469(9005)
		
	: ($object="handle_bm@")
		SET CURSOR:C469(9004)
		
	: ($object="handle_bl@")
		SET CURSOR:C469(9006)
		
	: ($object="handle_ml@")
		SET CURSOR:C469(9003)
		
	Else 
		
		SET CURSOR:C469(9002)
		
End case 