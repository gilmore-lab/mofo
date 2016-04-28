# Working script for Child MOFO data

source("child-tuning/analysis/prepare_environment.R")

# load data
df_all <- read.csv(fn_path)
df_egi <- read.csv(egi_path)

# Filter by direction or coherence conditions
df_all <- df_all %>% filter(Harm == harmonic, iCond %in% direction_conds)

# Compute channel-wise MANOVA
source("child-tuning/analysis/compute_chan_effects.R")
source("child-tuning/analysis/manova_channel.R")
source("child-tuning/analysis/make_stats_df.R")
source("child-tuning/analysis/extract_stats.R")
source("child-tuning/analysis/plot_channel_effects.R")
source("child-tuning/analysis/init_cap.R")
source("child-tuning/analysis/make_ears_nose_overlay.R")

form <- cbind(Sr, Si) ~ Direction + Speed + Direction*Speed + Error(iSess)
chan_eff <- compute_chan_effects(df_all, harmonic, form)
df_chan_stats <- make_stats_df(chan_eff, df_egi)
write.csv(x = df_chan_stats, file = "child-tuning/analysis/data/child-mofo-direction-stats.csv", row.names = FALSE)

# Plot channel-wise effects
plot_channel_effects(df_chan_stats, harmonic, group, topo_path, plot_titles)

# Plot magnitudes for channels meeting threshold
source("child-tuning/analysis/plot_channel_magnitudes.R")
source("child-tuning/analysis/compute_channel_vector_amplitudes.R")
source("child-tuning/analysis/select_chans_below.R")

plot_channel_magnitudes(df_chan_stats, df_all, group, harmonic, "Direction", p_thresh, plot_titles=plot_titles)
plot_channel_magnitudes(df_chan_stats, df_all, group, harmonic, "Speed", p_thresh, plot_titles=plot_titles)

# Plot complex domain results for n channels
source("child-tuning/analysis/plot_complex_domain_results.R")
source("child-tuning/analysis/compute_complex_domain_results.R")
plot_complex_domain_results(df_chan_stats, df_all, "Direction", group, harmonic, n_top, p_thresh, plot_titles=plot_titles)
plot_complex_domain_results(df_chan_stats, df_all, "Speed", group, harmonic, n_top, p_thresh, plot_titles=plot_titles)
