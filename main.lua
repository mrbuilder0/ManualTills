wait(5)
if game.ReplicatedStorage:WaitForChild("Infinity Tech License Service hZm5pYnpmbWpzd3JnY2pmb2l0Ii"):FindFirstChild("ManualTills") then
	if game.ReplicatedStorage:WaitForChild("Infinity Tech License Service hZm5pYnpmbWpzd3JnY2pmb2l0Ii"):FindFirstChild("ManualTills"):GetTags()[1] ~= "hZm5pYnpmbWpzd3JnY2pmdsab2l0Ii" then
		warn("Tampered License. Case reported.")
		script:Destroy()
	end
end
local till = script.Parent
local settings  = require(game.Workspace["IT | Manual Tills"].Configuration.Settings)

local ui = till.Staff_Screen.Screen.SurfaceGui
local uic = till.Customer_Screen.Screen.SurfaceGui
local scan = till.Activator.Scan
local event = script.Parent.Event


local CurrentCustomer

local cardp = Instance.new("Sound")
cardp.Parent = till.EFTReader
cardp.SoundId = "rbxassetid://0"
cardp.Volume = 0.3
cardp.Name = "cardp"

local bsound = Instance.new("Sound")
bsound.Parent = till.Scanner
bsound.SoundId = "rbxassetid://4499400560"
bsound.Volume = 0.1
bsound.RollOffMaxDistance = 20
bsound.Name = "bsound"

local ssound = Instance.new("Sound")
ssound.Parent = till.Scanner
ssound.SoundId = "rbxassetid://6121978751"
ssound.Volume = 0.1
ssound.RollOffMaxDistance = 20
ssound.Name = "ssound"

local csound = Instance.new("Sound")
csound.Parent = till.Scanner
csound.SoundId = "rbxassetid://4994833678"
csound.Volume = 0.1
csound.RollOffMaxDistance = 20
csound.Name = "csound"
csound.PlaybackSpeed = 2.25

local pitch = Instance.new("PitchShiftSoundEffect")
pitch.Octave = 2
pitch.Parent = csound


local ReceiptData = {
	["Total"] = 0,
	["Amount"] = 0,
	["Products"] = {
	}
}


wait(3)

local till_number = script.Parent:FindFirstChild("TillNumber").Value

local ScannedProductsFolder = Instance.new("Folder")
ScannedProductsFolder.Name = till_number
ScannedProductsFolder.Parent = game.ServerStorage

------------ Callable Functions ------------ 

------------ Scan -------------
local function scanF()
	scan.CanTouch = false
	till.Scanner.green_led.Transparency = 0.7
	till.Scanner.green_led.Material = "SmoothPlastic"
	till.Scanner.green_led.BrickColor = BrickColor.new("Institutional white")
	till.Scanner.red_led.Transparency = 1
	ssound:Play()
	wait(1)
	scan.CanTouch = true
	till.Scanner.green_led.Transparency = 0
	till.Scanner.green_led.BrickColor = BrickColor.new("Lime green")
	till.Scanner.green_led.Material = "Neon"
	till.Scanner.red_led.Transparency = 0
end

------------ Reset -------------

local function resetF()
	----Products Frame-----
	ui.Background.Scanframe.LeftFrame.ScrollingFrame:ClearAllChildren()
	uic.Background.Scanframe.LeftFrame.ScrollingFrame:ClearAllChildren()
	local l = Instance.new("UIListLayout")
	l.Parent = ui.Background.Scanframe.LeftFrame.ScrollingFrame
	local ll = l:Clone()
	ll.Parent = uic.Background.Scanframe.LeftFrame.ScrollingFrame
	----Action GUI-----
	ui.Background.Scanframe.RightFrame.UpperFrame.Till_functions.Text = "Till Functions"
	ui.Background.Scanframe.RightFrame.UpperFrame.Till_Secure.Text = "Till Secure"
	ui.Background.Scanframe.RightFrame.UpperFrame.Refund.Text = ""
	ui.Background.Scanframe.RightFrame.UpperFrame.ExtraFunction.Text = ""


	uic.Background.IFrame.Visible = false
	uic.Background.IFrame.Frame.Title.Text = " "
	uic.Background.IFrame.Frame.Description.Text = " "
	----Interruption Frame----
	ui.Background.IFrame.Visible = false
	----Total-----
	ReceiptData["Total"] = 0
	ui.Background.Scanframe.LeftFrame.LowerFrame.Total.Value.Text = settings.currency..ReceiptData["Total"]
	uic.Background.Scanframe.LeftFrame.LowerFrame.Total.Value.Text = settings.currency..ReceiptData["Total"]
	----Items Amount-----
	ReceiptData["Amount"] = #ui.Background.Scanframe.LeftFrame.ScrollingFrame:GetChildren()-1
	ui.Background.Scanframe.LeftFrame.LowerFrame.Item_amount.Value.Text = ReceiptData["Amount"]
	uic.Background.Scanframe.LeftFrame.LowerFrame.Item_amount.Value.Text = ReceiptData["Amount"]
	----Scanner-----
	scan.CanTouch = true
	till.Scanner.green_led.Transparency = 0
	till.Scanner.green_led.BrickColor = BrickColor.new("Lime green")
	till.Scanner.green_led.Material = "Neon"
	till.Scanner.red_led.Transparency = 0
	----Product List----
	table.clear(ReceiptData["Products"])
	if settings.store_items == true then
		game.ServerStorage:FindFirstChild(till_number):ClearAllChildren()
	end
	----Current Customer----
	CurrentCustomer = nil
end

------------ Log in/off -------------

--- IN ---
ui.Background.StandbyFrame.Frame.N.TextButton.MouseButton1Click:Connect(function()
	ui.Background.StandbyFrame.Frame.N.Visible = false
	ui.Background.StandbyFrame.Frame.S.Visible = true
	till.Scanner.green_led.Transparency = 0
	till.Scanner.green_led.BrickColor = BrickColor.new("Lime green")
	till.Scanner.green_led.Material = "Neon"
	till.Scanner.red_led.Transparency = 0
	scan.CanTouch = true
end)

ui.Background.StandbyFrame.Frame.S.TextButton.MouseButton1Click:Connect(function()
	ui.Background.StandbyFrame.Frame.N.Visible = true
	ui.Background.StandbyFrame.Frame.S.Visible = false
	till.Scanner.green_led.Transparency = 0.7
	till.Scanner.green_led.Material = "SmoothPlastic"
	till.Scanner.green_led.BrickColor = BrickColor.new("Institutional white")
	till.Scanner.red_led.Transparency = 1
	scan.CanTouch = false
end)

--- OFF ---

ui.Background.Scanframe.RightFrame.LowerFrame.Sign_off.MouseButton1Click:Connect(function()
	resetF()
	ui.Background.StandbyFrame.Visible = true
	scan.CanTouch = false
	till.Scanner.green_led.Transparency = 0.7
	till.Scanner.green_led.Material = "SmoothPlastic"
	till.Scanner.green_led.BrickColor = BrickColor.new("Institutional white")
	till.Scanner.red_led.Transparency = 1

	uic.Background.IFrame.Visible = true
	uic.Background.IFrame.Frame.Title.Text = ""
	uic.Background.IFrame.Frame.Description.Text = "Lane closed"
	if game.Workspace:FindFirstChild("IT | tillAvailability") then
		local AT_API = game.ReplicatedStorage.AT_API
		AT_API:Fire("remove", till_number)
	end
end)

------------ Scan -------------

scan.Touched:Connect(function(hit)
	if ui.Background.IFrame.Visible == true then
		return
	else
		if hit.Parent:IsA("Tool") then
			if ui.Background.StandbyFrame.Frame.S.Visible == true then
				if hit.Parent:GetAttribute("MRS_BARCODE") then
					ui.Background.StandbyFrame.Frame.N.Visible = true
					ui.Background.StandbyFrame.Frame.S.Visible = false
					ui.Background.StandbyFrame.Visible = false
					scan.CanTouch = true
					scanF()
					uic.Background.IFrame.Visible = false
					uic.Background.IFrame.Frame.Title.Text = ""
					uic.Background.IFrame.Frame.Description.Text = ""
					if game.Workspace:FindFirstChild("IT | tillAvailability") then
						local AT_API = game.ReplicatedStorage.AT_API
						AT_API:Fire("insert", till_number)
					end
				end
			else
				if hit.Parent:FindFirstChild("SCOItem") then
					if hit.Parent:FindFirstChild("MRS_EAS").Value == true then
						if game.Workspace:FindFirstChild("IT | tillAvailability") then
							local AT_API = game.ReplicatedStorage.AT_API
							AT_API:Fire("remove", till_number)
						end
						local label = Instance.new("TextLabel")
						local proof = hit.Parent.SCOItem

						label.Name = hit.Parent.Name
						label.Text = hit.Parent.Name.." - "..hit.Parent.SCOItem.Cost.Value..settings.currency
						label.Size = UDim2.new(1,0,0,30)
						label.TextSize = 18
						label.TextColor3 = Color3.new(0.552941, 0.552941, 0.552941)
						label.BackgroundTransparency = 1
						label.Parent = ui.Background.Scanframe.LeftFrame.ScrollingFrame

						local label2 = label:Clone()
						label2.Parent = uic.Background.Scanframe.LeftFrame.ScrollingFrame

						ui.Background.Scanframe.LeftFrame.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, ui.Background.Scanframe.LeftFrame.ScrollingFrame.UIListLayout.AbsoluteContentSize.Y)

						ReceiptData["Total"] = ReceiptData["Total"] + proof.Cost.Value
						ReceiptData["Total"] = math.round(ReceiptData["Total"] * 100)/100

						if ui.Background.Scanframe.LeftFrame.ScrollingFrame:FindFirstChild("coupon") then
							ReceiptData["Amount"] = #ui.Background.Scanframe.LeftFrame.ScrollingFrame:GetChildren()-2
						else
							ReceiptData["Amount"] = #ui.Background.Scanframe.LeftFrame.ScrollingFrame:GetChildren()-1
						end

						ui.Background.Scanframe.LeftFrame.LowerFrame.Total.Value.Text = settings.currency..ReceiptData["Total"]
						uic.Background.Scanframe.LeftFrame.LowerFrame.Total.Value.Text = settings.currency..ReceiptData["Total"]

						ui.Background.Scanframe.LeftFrame.LowerFrame.Item_amount.Value.Text = ReceiptData["Amount"]
						uic.Background.Scanframe.LeftFrame.LowerFrame.Item_amount.Value.Text = ReceiptData["Amount"]

						ReceiptData["Products"][hit.Parent.Name] = {price=proof.Cost.Value..settings.currency}

						if settings.store_items == true then
							CurrentCustomer = hit.Parent.Parent.Name

							local tool = hit.Parent
							tool.Parent = ScannedProductsFolder
						end

						hit.Parent:FindFirstChild("MRS_EAS").Value = false

						scanF()
					end
				else
					ui.Background.IFrame.Visible = true
					ui.Background.IFrame.Frame.Title.Text = ""
					ui.Background.IFrame.Frame.Description.Text = "Item not found"
					scan.CanTouch = false
					till.Scanner.green_led.Transparency = 0.7
					till.Scanner.green_led.Material = "SmoothPlastic"
					till.Scanner.green_led.BrickColor = BrickColor.new("Institutional white")
					till.Scanner.red_led.Transparency = 1
					wait(3)
					ui.Background.IFrame.Visible = false
					scan.CanTouch = true
					till.Scanner.green_led.Transparency = 0
					till.Scanner.green_led.BrickColor = BrickColor.new("Lime green")
					till.Scanner.green_led.Material = "Neon"
					till.Scanner.red_led.Transparency = 0
				end
			end
		end
	end
end)

------------ Coupons -------------

for i = 1,#ui.Background.Scanframe.RightFrame.LowerFrame.Coupons.Frame:GetChildren() do
	local coupon = ui.Background.Scanframe.RightFrame.LowerFrame.Coupons.Frame:GetChildren()[i]
	if coupon:IsA("TextButton") then
		coupon.MouseButton1Click:Connect(function()
			if ui.Background.Scanframe.LeftFrame.ScrollingFrame:FindFirstChild("coupon") then
				ui.Background.IFrame.Visible = true
				ui.Background.IFrame.Frame.Title.Text = ""
				ui.Background.IFrame.Frame.Description.Text = "Max. coupons applied"
				scan.CanTouch = false
				till.Scanner.green_led.Transparency = 0.7
				till.Scanner.green_led.Material = "SmoothPlastic"
				till.Scanner.green_led.BrickColor = BrickColor.new("Institutional white")
				till.Scanner.red_led.Transparency = 1
				wait(3)
				ui.Background.IFrame.Visible = false
				scan.CanTouch = true
				till.Scanner.green_led.Transparency = 0
				till.Scanner.green_led.BrickColor = BrickColor.new("Lime green")
				till.Scanner.green_led.Material = "Neon"
				till.Scanner.red_led.Transparency = 0
			else

				local percentage = ReceiptData["Total"] 
				percentage = coupon.Name / ReceiptData["Total"]
				print(percentage)
				local total = math.round(ReceiptData["Total"]-percentage)
				ReceiptData["Total"] = total
				print(ReceiptData["Total"])

				local label = Instance.new("TextLabel")

				label.Name = "coupon"
				label.Text = "Applied "..coupon.Name.."% coupon"
				label.Size = UDim2.new(1,0,0,30)
				label.TextSize = 18
				label.TextColor3 = Color3.new(1, 0.996078, 0.866667)
				label.BackgroundTransparency = 1
				label.Parent = ui.Background.Scanframe.LeftFrame.ScrollingFrame
				local clabel = label:Clone()
				clabel.Parent = uic.Background.Scanframe.LeftFrame.ScrollingFrame

				ui.Background.Scanframe.LeftFrame.LowerFrame.Total.Value.Text = settings.currency..ReceiptData["Total"]
				uic.Background.Scanframe.LeftFrame.LowerFrame.Total.Value.Text = settings.currency..ReceiptData["Total"]
				ReceiptData["Amount"] = #ui.Background.Scanframe.LeftFrame.ScrollingFrame:GetChildren()-2

				ui.Background.IFrame.Visible = true
				ui.Background.IFrame.Frame.Title.Text = ""
				ui.Background.IFrame.Frame.Description.Text = coupon.Name.."% coupon applied!"
				scan.CanTouch = false
				till.Scanner.green_led.Transparency = 0.7
				till.Scanner.green_led.Material = "SmoothPlastic"
				till.Scanner.green_led.BrickColor = BrickColor.new("Institutional white")
				till.Scanner.red_led.Transparency = 1
				wait(3)
				ui.Background.IFrame.Visible = false
				scan.CanTouch = true
				till.Scanner.green_led.Transparency = 0
				till.Scanner.green_led.BrickColor = BrickColor.new("Lime green")
				till.Scanner.green_led.Material = "Neon"
				till.Scanner.red_led.Transparency = 0
			end
		end)
	end
end


------------ Payment -------------
ui.Background.Scanframe.RightFrame.LowerFrame.Subtotal.MouseButton1Click:Connect(function()
	if ui.Background.IFrame.Visible == true then
		return
	else
		if ReceiptData["Total"] == 0 then
			return
		else
			scan.CanTouch = false
			till.Scanner.green_led.Transparency = 0.7
			till.Scanner.green_led.Material = "SmoothPlastic"
			till.Scanner.green_led.BrickColor = BrickColor.new("Institutional white")
			till.Scanner.red_led.Transparency = 1

			ui.Background.Scanframe.RightFrame.UpperFrame.Till_functions.Text = "General EFT"
			ui.Background.Scanframe.RightFrame.UpperFrame.Till_Secure.Text = "CASH"
			ui.Background.Scanframe.RightFrame.UpperFrame.Refund.Text = " "
			ui.Background.Scanframe.RightFrame.UpperFrame.ExtraFunction.Text = "Back"
		end
	end
end)

ui.Background.Scanframe.RightFrame.UpperFrame.ExtraFunction.MouseButton1Click:Connect(function()
	if ui.Background.IFrame.Visible == true then
		return
	else
		if ui.Background.Scanframe.RightFrame.UpperFrame.Till_functions.Text == "General EFT" then
			scan.CanTouch = true
			till.Scanner.green_led.Transparency = 0
			till.Scanner.green_led.BrickColor = BrickColor.new("Lime green")
			till.Scanner.green_led.Material = "Neon"
			till.Scanner.red_led.Transparency = 0

			ui.Background.Scanframe.RightFrame.UpperFrame.Till_functions.Text = "Till Functions"
			ui.Background.Scanframe.RightFrame.UpperFrame.Till_Secure.Text = "Till Secure"
			ui.Background.Scanframe.RightFrame.UpperFrame.Refund.Text = ""
			ui.Background.Scanframe.RightFrame.UpperFrame.ExtraFunction.Text = ""
		end
	end
end)

ui.Background.Scanframe.RightFrame.UpperFrame.Till_functions.MouseButton1Click:Connect(function()
	if ui.Background.Scanframe.RightFrame.UpperFrame.Till_functions.Text == "General EFT" then
		scan.CanTouch = false
		till.Scanner.green_led.Transparency = 0.7
		till.Scanner.green_led.Material = "SmoothPlastic"
		till.Scanner.green_led.BrickColor = BrickColor.new("Institutional white")
		till.Scanner.red_led.Transparency = 1

		ui.Background.IFrame.Visible = true
		ui.Background.IFrame.Frame.Title.Text = "Payment"
		ui.Background.IFrame.Frame.Description.Text = "Continue on pin pad"

		uic.Background.IFrame.Visible = true
		uic.Background.IFrame.Frame.Title.Text = "Continue on pin pad"
		uic.Background.IFrame.Frame.Description.Text = "Total: "..settings.currency..ReceiptData["Total"]

		event:Fire("EFT",ReceiptData["Total"], settings.currency)

	elseif ui.Background.Scanframe.RightFrame.UpperFrame.Till_functions.Text == "Till Functions" then
		ui.Background.Scanframe.RightFrame.UpperFrame.ExtraFunction.Text = "Back"
		ui.Background.Scanframe.RightFrame.UpperFrame.Till_functions.Text = "Void"
		ui.Background.Scanframe.RightFrame.UpperFrame.Till_Secure.Text = ""
	elseif ui.Background.Scanframe.RightFrame.UpperFrame.Till_functions.Text == "Void" then
		scan.CanTouch = false
		till.Scanner.green_led.Transparency = 0.7
		till.Scanner.green_led.Material = "SmoothPlastic"
		till.Scanner.green_led.BrickColor = BrickColor.new("Institutional white")
		till.Scanner.red_led.Transparency = 1

		resetF()
		ui.Background.IFrame.Visible = true
		ui.Background.IFrame.Frame.Title.Text = ""
		ui.Background.IFrame.Frame.Description.Text = "Transaction canceled"
		wait(3)
		ui.Background.IFrame.Visible = false

		scan.CanTouch = true
		till.Scanner.green_led.Transparency = 0
		till.Scanner.green_led.BrickColor = BrickColor.new("Lime green")
		till.Scanner.green_led.Material = "Neon"
		till.Scanner.red_led.Transparency = 0

		if game.Workspace:FindFirstChild("IT | tillAvailability") then
			local AT_API = game.ReplicatedStorage.AT_API
			AT_API:Fire("insert", till_number)
		end
	end
end)


till.Staff_Screen.Screen.SurfaceGui.Background.Scanframe.LeftFrame.LowerFrame.ITGo.MouseButton1Click:Connect(function(plr)
	if game.ReplicatedStorage:FindFirstChild("ITGoServer") then
		till.Staff_Screen.Screen.SurfaceGui.Background.Scanframe.LeftFrame.LowerFrame.ITGo.Active = false

		local data = {
			["Type"] = "System",
			["Title"] = "System Message",
			["Text"] = plr.Name.." requires assistance at: Manual till"..till_number,
			["ImageID"] = "rbxassetid://15264229050",
		}
		game.ReplicatedStorage.ITGoServer:FireAllClients(data)
		wait(5)
		till.Staff_Screen.Screen.SurfaceGui.Background.Scanframe.LeftFrame.LowerFrame.ITGo.Active = false
	else
		return
	end
end)

event.Event:Connect(function(mode, arg1, arg2)
	if mode == "EFTb" then
		if arg1 == "success" then
			uic.Background.IFrame.Visible = true
			uic.Background.IFrame.Frame.Title.Text = " "
			uic.Background.IFrame.Frame.Description.Text = "Thank you for shopping with us!"
			if script.Parent["Printer 3738"] then
				script.Parent.Event:Fire("Printer", ReceiptData)
			end
			if settings.store_items == true then
				local folder = game.ServerStorage:FindFirstChild(till_number)
				for i = 1,#folder:GetChildren() do
					local Product = folder:GetChildren()[i]
					Product.Parent = game.Players:FindFirstChild(CurrentCustomer).Backpack
				end
			end
			if game.Workspace:FindFirstChild("IT | tillAvailability") then
				local AT_API = game.ReplicatedStorage.AT_API
				AT_API:Fire("insert", till_number)
			end
			resetF()
		end
	end
end)
