class Api::V2::StripeChargesController < ApiController 
# #display stripe status of Charge to know if user has access or not

	def index
		authorize do |user|
			begin
				pullCardHolderx = Stripe::Issuing::Cardholder.retrieve(Stripe::Customer.retrieve(user&.stripeCustomerID)['metadata']['cardHolder'])
				deposits = Stripe::PaymentIntent.list(limit: 100, customer: user&.stripeCustomerID)['data']
				available = !pullCardHolderx['spending_controls']['spending_limits'].blank? ? pullCardHolderx['spending_controls']['spending_limits'].first['amount'] : 0
				groupPrincipleArray =  []
				payoutTotalsArray = []





				# self charge totals (platform) -> total transactions or money moved
				filteredDeposits = deposits.reject{|e| e['charges']['data'][0]['refunded'] == true}.reject{|e| !e['metadata']['percentToInvest'].present?}.reject{|e| e['charges']['data'][0]['captured'] == false}
				

				# investment totals (platform) -> "the Pot" we had for investing
				# payout totals (platform)




				groupPrincipleArray = []

				filteredDeposits.each do |depositX|
					# investment totals (personal)
					if !depositX['metadata']['percentToInvest'].blank?
						chargeXChargeAmount = User.paymentIntentNet(depositX['id'])[:amount] * 0.01
						chargeXChargeNet = User.paymentIntentNet(depositX['id'])[:net] * 0.01
						groupPrincipleArray << {amount: chargeXChargeAmount,net: chargeXChargeNet, depositX['customer'].to_sym => (chargeXChargeNet * (depositX['metadata']['percentToInvest'].to_i * 0.01).to_f) }
					end
				end

				# payout totals (personal)



				# reinvestment totals (personal & platform) -> once done

				syncForUser = groupPrincipleArray.flatten.any? {|h| h[user&.stripeCustomerID.to_sym].present?}

				case true
        when syncForUser
          investmentTotalForUserX = groupPrincipleArray.flatten.map{|e| e[user&.stripeCustomerID.to_sym]}.compact.sum  
        end

        selfChargeTotal = groupPrincipleArray.flatten.map{|e| e[:amount]}.compact.sum
        
				render json: {
					selfCharges: filteredDeposits,
					available: available,
					selfChargeTotal: selfChargeTotal,
					invested: investmentTotalForUserX ,
					success: true
				}
			rescue Stripe::StripeError => e
				render json: {
					error: e,
					success: false
				}
			rescue Exception => e
				render json: {
					message: e
				}
			end	
		end
	end

	def create
		authorize do |user|
			begin
				stripeAmountX = User.stripeAmount(params[:amount].to_i)
				charge = Stripe::PaymentIntent.create({
				  amount: stripeAmountX + (stripeAmountX*0.029).to_i.round(-1) + 30,
				  currency: 'usd',
				  customer: user&.stripeCustomerID, #request to token endpoint?
				  description: "Netwerth Card Deposit: #{params[:amount].to_i}",
				  confirm: true
				})
				

				render json: {
					success: true,
					charge: charge
				}
			rescue Stripe::StripeError => e
				render json: {
					message: e.error.message
				}
			rescue Exception => e
				render json: {
					message: e
				}
			end
		end
	end

	private

	def stripeAllowed
		paramsClean = params.permit(:amount, :description, :connectAccount, :source, :inHouse)
		return paramsClean.reject{|_, v| v.blank?}
	end

	def cardTokenParams
		platparamsClean = params.permit(:number, :exp_year, :exp_month, :cvc)
		return platparamsClean.reject{|_, v| v.blank?}
	end
end