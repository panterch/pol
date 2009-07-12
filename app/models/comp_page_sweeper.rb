class CompPageSweeper < ActionController::Caching::Sweeper
  observe Comp
  
  def after_save(record)
    sweep_comp_page(record)
  end
  
  def after_destroy(record)
    sweep_comp_page(record)
  end
  
  # sweep the cached page that holds the component record
  def sweep_comp_page(comp)
    cache_dir = ActionController::Base.page_cache_directory
    page = comp.page
    while page.nil? do
      page = comp.parent.page
    end
    files = Dir.glob(File.join(cache_dir, page.permalink) + ".*")
    FileUtils.rm(files) rescue Errno::ENOENT
    RAILS_DEFAULT_LOGGER.info("Cache files '#{files}' sweeped.")
  end
end
