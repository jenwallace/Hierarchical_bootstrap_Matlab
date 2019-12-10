function make_cdf_plot(vector,cmp)
    cdf_handles = cdfplot(vector);
    cdf_handles.LineWidth = 1;
    cdf_handles.Color = cmp;
end