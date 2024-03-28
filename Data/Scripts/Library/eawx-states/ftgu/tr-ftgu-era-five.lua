return {
    on_enter = function(self, state_context)

        GlobalValue.Set("CURRENT_ERA", 5)
		
		self.entry_time = GetCurrentTime()
        self.EventsFired = false

    end,
    on_update = function(self, state_context)
		local current = GetCurrentTime() - self.entry_time
        if (current >=5) and (self.EventsFired == false) then
            self.EventsFired = true
            crossplot:publish("REPUBLIC_RESEARCH_FINISHED", "empty")
            crossplot:publish("NCMP_RESEARCH_FINISHED", "empty")
			crossplot:publish("CORONA_RESEARCH_FINISHED", "empty")
			crossplot:publish("NCMP2_RESEARCH_FINISHED", "empty")
        end
    end,
    on_exit = function(self, state_context)
    end
}